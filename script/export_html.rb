#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'redcarpet'

# Contributors収集は削除

# TODO title とAuthor, 著作権表示は書き換えて下さい
HEADER = <<HEAD
<html>
<head>
<title>Process Book</title>
<meta name="Author" content="Shinpei Maruyama">
<meta name="DC.date.publication" content="2013-03">
<meta name="DC.rights" content="Shinpei Maruyama">
<link rel="stylesheet" href="../styles/epub.css" type="text/css" />
<style>
  /* カラーパレット */
  :root {
    --teal: #85B0B7;
    --sage: #BDD0CA;
    --coral: #EE5840;
    --dark-teal: #5A8A92;
    --light-sage: #D8E5DD;
    --text-primary: #2C3E50;
    --text-secondary: #5D6D7E;
    --background: #FAFAFA;
    --white: #FFFFFF;
  }

  /* リセットと基本スタイル */
  * {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
  }

  body {
    font-family: 'Hiragino Sans', 'Noto Sans JP', 'Yu Gothic', sans-serif;
    line-height: 1.8;
    color: var(--text-primary);
    background-color: var(--background);
    padding: 20px;
  }

  /* ブックコンテナ */
  .book {
    max-width: 800px;
    margin: 0 auto;
    background-color: var(--white);
  }

  /* タイトルページ */
  .titlepage {
    background: var(--white);
    color: var(--text-primary);
    padding: 120px 40px;
    text-align: center;
  }

  .title {
    font-size: 2.5em;
    font-weight: 400;
    margin-bottom: 30px;
    letter-spacing: 0.02em;
    color: var(--dark-teal);
  }

  .author {
    margin-top: 40px;
  }

  .author h3 {
    font-size: 1em;
    font-weight: 400;
    margin: 10px 0;
    color: var(--text-secondary);
  }

  /* 見出し */
  h1, h2, h3, h4, h5, h6 {
    color: var(--dark-teal);
    margin-top: 2em;
    margin-bottom: 1em;
    font-weight: 600;
  }

  h1 {
    font-size: 2.5em;
    border-bottom: 3px solid var(--teal);
    padding-bottom: 0.5em;
  }

  h2.chapter {
    font-size: 2em;
    padding: 0.5em 0;
    border-bottom: 2px solid var(--sage);
  }

  h3 {
    font-size: 1.5em;
    color: var(--teal);
  }

  /* 段落とテキスト */
  p {
    margin-bottom: 1.5em;
    color: var(--text-primary);
  }

  /* リンク */
  a {
    color: var(--coral);
    text-decoration: none;
    border-bottom: 1px solid transparent;
    transition: border-bottom-color 0.3s ease;
  }

  a:hover {
    border-bottom-color: var(--coral);
  }

  /* コードブロック */
  pre {
    background-color: var(--light-sage);
    padding: 1.5em;
    margin: 1.5em 0;
    overflow-x: auto;
    border-radius: 4px;
  }

  code {
    font-family: 'Courier New', Consolas, monospace;
    font-size: 0.9em;
    background-color: var(--light-sage);
    padding: 0.2em 0.4em;
    border-radius: 3px;
    color: var(--text-primary);
  }

  pre code {
    background-color: transparent;
    padding: 0;
  }

  /* リスト */
  ul, ol {
    margin-left: 2em;
    margin-bottom: 1.5em;
  }

  li {
    margin-bottom: 0.5em;
  }

  /* 引用 */
  blockquote {
    padding-left: 1.5em;
    margin: 1.5em 0;
    font-style: italic;
    color: var(--text-secondary);
    background-color: rgba(189, 208, 202, 0.1);
    padding: 1em 1.5em;
  }

  /* 画像 */
  img {
    max-width: 100%;
    height: auto;
    display: block;
    margin: 2em auto;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
    border-radius: 4px;
  }

  /* テーブル */
  table {
    width: 100%;
    border-collapse: collapse;
    margin: 1.5em 0;
  }

  th, td {
    padding: 0.75em 1em;
    text-align: left;
    border-bottom: 1px solid var(--sage);
  }

  th {
    background-color: var(--teal);
    color: var(--white);
    font-weight: 600;
  }

  tr:hover {
    background-color: rgba(189, 208, 202, 0.1);
  }

  /* コンテンツパディング */
  body > p,
  body > h1,
  body > h2,
  body > h3,
  body > h4,
  body > h5,
  body > h6,
  body > ul,
  body > ol,
  body > blockquote,
  body > pre,
  body > table {
    margin-left: 40px;
    margin-right: 40px;
  }

  /* 印刷用スタイル */
  @media print {
    body {
      background-color: white;
      padding: 0;
    }

    .book {
      box-shadow: none;
    }

    .titlepage {
      break-after: page;
    }

    h2.chapter {
      break-before: page;
    }
  }
</style>
</head>
<body>
<div class='book'>
  <div class='titlepage'>
    <h1 class='title'>Process Book</h1>
    <div class='author'>
      <h3>Author: Shinpeim</h3>
    </div>
  </div>
</div>
HEAD

def replace_index(html)
  h2_id  = 1
  mod = ''
  
  # シンプルなアプローチに戻す
  # ただし、実際の章（001.mdなど）が始まるまでIDをスキップ
  in_toc = false
  skip_count = 0
  
  html.each_line do |line|
    # 目次セクションの検出
    if line =~ %r!<h2>目次</h2>!
      in_toc = true
    elsif in_toc && line =~ %r!</ul>!  # 目次の終わり（仮定）
      in_toc = false
    end
    
    # h2タグにIDを付与
    if line =~ %r!<h2>!
      if skip_count < 3  # README部分のh2をスキップ（この文書はなんですか、目次、ライセンス）
        line.gsub! %r!<h2>!, %!<h2 class="chapter">!
        skip_count += 1
      else
        # 実際の章番号
        chapter_num = h2_id
        line.gsub! %r!<h2>!, %!<h2 class="chapter" id="chapter-#{format('%03d', chapter_num)}">!
        h2_id += 1
      end
    # 目次のリンクを内部リンクに変換（番号付きのmdファイルへのリンク）
    elsif line.gsub! %r!<a href="/(\d{3})\.md">!, '<a href="#chapter-\1">'
      # 番号はそのまま使用
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
