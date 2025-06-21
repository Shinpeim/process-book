#!/usr/bin/env node

const puppeteer = require('puppeteer');
const path = require('path');
const fs = require('fs');

async function generatePDF() {
  const htmlPath = path.join(__dirname, '..', 'release', 'index.html');
  const pdfPath = path.join(__dirname, '..', 'release', 'process_book.pdf');

  // HTMLファイルが存在するか確認
  if (!fs.existsSync(htmlPath)) {
    console.error(`HTML file not found: ${htmlPath}`);
    process.exit(1);
  }

  const browser = await puppeteer.launch({
    headless: 'new',
    args: ['--no-sandbox', '--disable-setuid-sandbox']
  });

  try {
    const page = await browser.newPage();
    
    // ローカルファイルを読み込む
    await page.goto(`file://${htmlPath}`, {
      waitUntil: 'networkidle0'
    });

    // PDFを生成
    await page.pdf({
      path: pdfPath,
      format: 'A4',
      printBackground: true,
      margin: {
        top: '30mm',
        right: '25mm',
        bottom: '30mm',
        left: '25mm'
      }
    });

    console.log(`PDF generated: ${pdfPath}`);
  } catch (error) {
    console.error('Error generating PDF:', error);
    process.exit(1);
  } finally {
    await browser.close();
  }
}

generatePDF();