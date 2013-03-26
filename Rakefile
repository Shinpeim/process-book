task :default => "book"

task book: [:epub, :pdf, :clean]

if File.exists?('working')
  sh "rm -rf ./working"
end
sh "mkdir ./working"
sh "cp *.md working/"
sh "mv working/README.md working/000.README.md"

file html: Dir.glob('./working/*.md') do |task|
  sh "script/export_html.rb #{task.prerequisites.join(' ')} > release/process_book.html"
end

task epub: %w[html] do
  sh "ebook-convert release/process_book.html release/process_book.epub --no-default-epub-cover"
end

task pdf: %w[html] do
  sh "wkhtmltopdf release/process_book.html release/process_book.pdf --encoding utf8"
end

task :clean do
  sh "rm -rf working"
end
