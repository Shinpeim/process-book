task :default => 'md'

desc 'get markdown files from master branch'
task :md do
  # index generate from README.md
  sh 'echo "---\n---" > ./index.md'
  sh 'git show master:README.md | sed -e "s|(/\(00[0-9]\).md)|(./\1.md)|" >> ./index.md'

  # posts generate from 00[1-8].md
  8.times {|n| sh "git show master:00#{n + 1}.md > ./_posts/1970-01-01-00#{n + 1}.md" }
end
