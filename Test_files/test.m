proj = openProject("Matlab_Jenkins.prj"); 
sltestmgr; 
testFile = sltest.testmanager.load('Matlab_Jenkins_Automated.mldatx'); 
testSuite = getTestSuiteByName(testFile,'Test Scenarios'); 
testCase = getTestCaseByName(testSuite,'Test_Case1'); 
resultObj = run(testCase);