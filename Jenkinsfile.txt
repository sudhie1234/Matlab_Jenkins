pipeline {
    agent any 
    stages {
        stage('Build & Test'){
            matrix {
                agent {
                    label 'Windows'
                }
                
                axes {
                    axis {
                        name 'MATLAB_VERSION'
                        values 'R2023a'
                    }
                }
                
                tools{
                    matlab "${MATLAB_VERSION}"
                }
                
                stages {
                    stage('Run MATLAB Command') {
                        steps {
                            runMATLABCommand 'buildMEXfiles'
                        }
                    }
                    
                    stage('Run MATLAB Test') {
                        steps {
                            runMATLABTests(testResultsJUnit: 'test-result/result.xml', sourceFolder: ['Test_files'])
                        }
                    }
                }
            }
        }
    }
}
