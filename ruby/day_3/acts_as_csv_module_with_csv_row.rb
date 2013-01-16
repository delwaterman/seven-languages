#---
# Excerpted from "Seven Languages in Seven Weeks",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/btlang for more book information.
#---
module ActsAsCsv
  def self.included(base)
    base.extend ClassMethods
  end
  
  module ClassMethods
    def acts_as_csv
      include InstanceMethods
    end
  end
  
  module InstanceMethods   
    def read
      @csv_contents = []
      filename = self.class.to_s.downcase + '.txt'
      file = File.new(filename)
      @headers = file.gets.chomp.split(', ')

      file.each do |row|
        @csv_contents << CsvRow.new(@headers, row.chomp.split(', '))
      end
    end
    
    attr_accessor :headers, :csv_contents
    def initialize
      read 
    end
  end

  class CsvRow
    
    def initialize(headers, row)
      @_row_data = {}
      headers.each_with_index do |header, ix|
        @_row_data[header] = row[ix]
      end
    end
    
    def method_missing(*args)
      if args.length == 1 && headers.include?(args.first.to_s)
        @_row_data[args.first.to_s]
      else
        super
      end
    end
    
    private
    
    def headers
      @_row_data.keys
    end
    
  end
end

class RubyCsv  # no inheritance! You can mix it in
  include ActsAsCsv
  acts_as_csv
end

m = RubyCsv.new
puts m.headers.inspect
puts m.csv_contents.inspect
puts "testing method missing:"
m.csv_contents.each do |csv_row|
  %w(first last country).each do |method|
    puts "csv_row.#{method}: #{csv_row.send(method)}"
  end
end



