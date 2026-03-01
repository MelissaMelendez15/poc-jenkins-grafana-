pipeline {
    agent any

    options {
        timestamps()
    }

    parameters {
        string(name: 'INPUT', defaultValue: '50', description: 'Valor demo para alimentar 4 métricas en Grafana')
    }

    stages {
        stage('Enviar métricas a Pushgateway') {
            steps {
               sh '''
                set -eu
                chmod +x ./scripts/push_metrics.sh
               ./scripts/push_metrics.sh "${params.INPUT}"
               
               '''
            }
        }
    }

    post {
        success {
            echo "Métricas enviadas exitosamente a Pushgateway (INPUT=${params.INPUT})."
        }
        
        failure {
            echo 'Fallo enviando métricas a Pushgateway. Revisa conectividad y curl.'
        }
        
        always {
            echo ' Fin del pipeline PoC.'
        }
    }
}