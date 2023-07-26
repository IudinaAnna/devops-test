module.exports = {
    preset: "ts-jest",
    testEnvironment: "node",
    resetMocks: true,
    restoreMocks: true,
    reporters: [ "default",
        ["./node_modules/jest-html-reporter", {
            pageTitle: "HTML Report for unit react component test",
            outputPath: "jest-test-report/index.html",
            includeFailureMsg: true,
            includeSuiteFailure: true
        }]
    ]
};