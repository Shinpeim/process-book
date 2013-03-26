#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'redcarpet'

contributors = `git log --pretty=format:'%cn'`
contributors = contributors.split("\n")
contributors.sort!
contributors.uniq!
contributors.delete_if do |e|
  e =~ /shinpei maruyama/i
end

# TODO title とAuthor, 著作権表示は書き換えて下さい
HEADER = <<HEAD
<html>
<head>
<title>Process Book</title>
<meta name="Author" content="Shinpei Maruyama">
<meta name="DC.date.publication" content="2013-03">
<meta name="DC.rights" content="Shinpei Maruyama">
<link rel="stylesheet" href="../styles/epub.css" type="text/css" />
</head>
<body>
<div class='book'>
  <div class='titlepage'>
    <h1 class='title'>Process Book</h1>
    <div class='author'>
      <h3>Author: Shinpeim</h3>
      <h3>Contributors: #{contributors.join ", "}<h3>
    </div>
  </div>
</div>
HEAD

def replace_index(html)
  h2_id  = 0
  a_id   = 2
  mod = ''
  html.each_line do |line|
    if line.gsub! %r!<h2>!, %!<h2 class="chapter" id="#{h2_id}">!
      h2_id += 1
    elsif line.gsub! %r!<p><a href="https://github\.com/Shinpeim/process-book/blob/master/...\.md">!, %!<p><a href=##{a_id}>!
      a_id += 1
    end
    mod += line
  end
  mod
end

def replace(html)
  mod = replace_index(html)
  mod.gsub %r!<img src="https://raw.github.com/Shinpeim/process-book/master/images/!, %q!<img src="../images/!
end

markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :space_after_headers => true)
STDOUT.write HEADER
STDOUT.write replace(markdown.render(ARGF.readlines.join ''))
STDOUT.write "</body></html>\n"
