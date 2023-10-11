import matlab.unittest.TestRunner;
import matlab.unittest.Verbosity;
import matlab.unittest.plugins.XMLPlugin;
import matlab.unittest.plugins.TestReportPlugin;
import matlab.unittest.plugins.CodeCoveragePlugin;
import matlab.unittest.plugins.codecoverage.CoverageReport;
import matlab.unittest.plugins.TAPPlugin;
import matlab.unittest.plugins.ToFile;

addpath(genpath('Test_files'));

%suite = testsuite(pwd, 'IncludeSubfolders', true);

proj = openProject("Matlab_Jenkins.prj"); 
sltestmgr; 
testFile = sltest.testmanager.load('Matlab_Jenkins_Automated.mldatx'); 
testSuite = getTestSuiteByName(testFile,'Test Scenarios'); 
testCase = getTestCaseByName(testSuite,'Test_Case1'); 

[~,~] = mkdir('matlabTestArtifacts');

runner = TestRunner.withTextOutput('OutputDetail', Verbosity.Detailed );
runner.addPlugin(TestReportPlugin.producingHTML('testReport'));
runner.addPlugin(TAPPlugin.producingVersion13(ToFile('matlabTestArtifacts/taptestresults.tap')));
runner.addPlugin(XMLPlugin.producingJUnitFormat('matlabTestArtifacts/junittestresults.xml'));
runner.addPlugin(CodeCoveragePlugin.forFolder({'Test_files'}, 'IncludingSubfolders', true, 'Producing', CoverageReport('covReport', ...
   'MainFile','index.html')));

results = runner.run(testCase);

% Generate Zip files
% zip('covReport.zip','covReport');
nfailed = nnz([results.Failed]);
assert(nfailed == 0, [num2str(nfailed) ' test(s) failed.']);
