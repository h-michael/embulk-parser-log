module Embulk
  module Parser

    class Ltsv < ParserPlugin
      Plugin.register_parser("ltsv", self)

      def self.transaction(config, &control)
        parser_task = config.load_config(Java::LineDecoder::DecoderTask)
        task = {
          'decoder_task' => DataSource.from_java(parser_task.dump),
          'columns' => config.param('columns', :array)
        }

        columns = task['columns'].each_with_index.map do |c, i|
          Column.new(i, c['name'], c['type'].to_sym)
        end

        yield(task, columns)
      end

      def init
        @decoder_task = task.param('decoder_task', :hash).load_task(Java::LineDecoder::DecoderTask)
        @columns =  task['columns']
      end

      def run(file_input)
        decoder = Java::LineDecoder.new(file_input.instance_eval { @java_file_input }, @decoder_task)
        columns = @task['columns']

        while decoder.nextFile
          while line = decoder.poll
            hash = Hash[line.split("\t").map { |column| column.split(':', 2) }]
            record = make_record(hash)
            page_builder.add(record)
          end
        end
        page_builder.finish
      end

      private

      def make_record(hash)
        @columns.map do |column|
          buffer_val = hash[column['name']]
          value = buffer_val.nil? ? '' : buffer_val
          case column['type']
          when 'string'
            value
          when 'long'
            value.to_i
          when 'double'
            value.to_f
          when 'boolean'
            %w(yes true 1).include?(v.downcase)
          when 'timestamp'
            if column['surrounded'] == true
              value.empty? ? nil : Time.strptime(value.gsub(/(^.|.$)/, ''), column['format'])
            else
              value.empty? ? nil : Time.strptime(value, column['format'])
            end
          else
            fail "Unsupported type #{column['type']}"
          end
        end
      end
    end

  end
end
