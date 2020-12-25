def read_input
  task_number = $PROGRAM_NAME.split('/').first

  if ARGV.first
    Object.const_get 'SAMPLE_INPUT'
  else
    File.read "#{__dir__}/inputs/#{task_number}.txt"
  end
rescue Errno::ENOENT
  puts "Input file for task (#{task_number}) not found."
  exit 1
rescue NameError
  puts 'No sample input available.'
  exit 2
end
