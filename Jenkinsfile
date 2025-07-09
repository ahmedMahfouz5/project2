pipeline {
    agent any


        stages {
        stage('Clone Repository') {
            steps {
                // Clean workspace before cloning (optional)
                deleteDir()

                // Clone the Git repository
                git branch: 'main',
                    url: 'https://github.com/ahmedMahfouz5/project2.git'

                sh "ls -lart"
            }
        }
    }
}