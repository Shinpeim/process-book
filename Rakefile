task :default => "book"

task book: [:pdf, :clean]

WORKING_DIR = './working'
RELEASE_DIR = './release'

file init: FileList['./*.md'] do |task|
  mkdir WORKING_DIR unless File.exists?(WORKING_DIR)
  mkdir RELEASE_DIR unless File.exists?(RELEASE_DIR)
  cp task.prerequisites, WORKING_DIR
  mv "#{WORKING_DIR}/README.md", "#{WORKING_DIR}/000.README.md"
end

task html: %w[init] do
  sh "script/export_html.rb #{FileList["./#{WORKING_DIR}/*.md"].join(' ')} > #{RELEASE_DIR}/index.html"
end

task pdf: %w[html] do
  sh "wkhtmltopdf #{RELEASE_DIR}/index.html #{RELEASE_DIR}/process_book.pdf --encoding utf8"
end

task :clean do
  sh "rm -rf #{WORKING_DIR}"
end
