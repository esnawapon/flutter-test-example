var reporter = require('cucumber-html-reporter');

var options = {
  theme: "bootstrap",
  jsonFile: "./test/driver/report.json",
  output: "./test/driver/report.html",
  reportSuiteAsScenarios: true,
  scenarioTimestamp: true,
  launchReport: true,
  metadata: {
    "App Version":"1.0.0",
  }
};

reporter.generate(options);
