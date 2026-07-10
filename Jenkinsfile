@Library('hello-world-shared-library') _

basePipeline(
    repo: 'https://github.com/ThummaUma/hello-world-app.git'
) {

    deploymentPipeline([
        codeRepoUrl    : 'https://github.com/ThummaUma/hello-world-app.git',
        dockerHubRepo  : 'umathumma/hello-world-app',
        manifestRepoUrl: 'https://github.com/ThummaUma/hello-world-manifests.git',
        valuesFile     : 'charts/hello-world-app/values.yaml'
    ])
}
