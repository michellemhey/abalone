class CsvImporter
  attr_reader :stats, :model, :filename, :processed_file_id, :errored
  alias :errored? :errored

  CATEGORIES = [
      'Spawning Success',
      'Tagged Animal Assessment',
      'Untagged Animal Assessment',
      'Wild Collection',
  ].freeze

  class InvalidCategoryError < StandardError; end;

  def initialize(filename, category_name, processed_file_id)
    @filename = filename
    @processed_file_id = processed_file_id
    @model = model_from_category(category_name)
    @stats = Hash.new(0)
    @stats[:shl_case_numbers] = Hash.new(0)
    @errored = false
  end

  def call
    process
  end

  private

  def process
    model.transaction do
      IOStreams.each_record(filename) do |csv_row|
        csv_row[:processed_file_id] = processed_file_id
        csv_row[:raw] = false
        record = model.create_from_csv_data(csv_row)
        record.cleanse_data! if record.respond_to?(:cleanse_data!)

        unless record.save
          @stats = Hash.new(0)
          @errored = true 
          raise ActiveRecord::Rollback
        end

        increment_stats(record)
      end
    end
  end

  def model_from_category(category_name)
    if CATEGORIES.include?(category_name)
      category_name.delete(' ').constantize
    else
      raise InvalidCategoryError
    end
  end

  def increment_stats(model)
    stats[:row_count] += 1
    if model.persisted?
      stats[:rows_imported] += 1
      stats[:shl_case_numbers][model.shl_case_number] += 1 if model.respond_to?(:shl_case_number)
    else
      stats[:rows_not_imported] += 1
    end
  end
end
