const puppeteer = require("puppeteer");
const {
  default: fullPageScreenshot,
} = require("puppeteer-full-page-screenshot");
const httpServer = require("http-server");
const path = require("path");

if (process.argv.length < 3) {
  console.error("Missing folder");
  process.exit(1);
}

const folder = process.argv[2];

const port = 8000;
const host = `localhost:${port}`;

const deviceViewports = {
  iPhone7: { width: 375, height: 557, deviceScaleFactor: 2 },
  HiDPI: { width: 1440, height: 900, deviceScaleFactor: 1 },
};

const outputs = [
  { filenamePostfix: "small", viewport: deviceViewports.iPhone7 },
  { filenamePostfix: "large", viewport: deviceViewports.HiDPI },
];

(async () => {
  const server = await httpServer.createServer({
    root: path.join(__dirname, folder),
  });
  server.listen(port);

  const browser = await puppeteer.launch({ args: ["--no-sandbox"] });

  await Promise.all(
    outputs.map(async (output) => {
      const page = await browser.newPage();
      await page.setViewport(output.viewport);
      await page.goto(`http://${host}/index.html`);

      await fullPageScreenshot(page, {
        path: `${folder}/preview-${output.filenamePostfix}.png`,
      });
    })
  );

  await browser.close();
  server.close();
})();
