#!/usr/bin/env groovy

node('master') {
    // jerbs from jerbs
    def jerbs = fileLoader.fromGit('cookbook_pipeline/jerbs',
        'https://github.marchex.com/marchex-chef/groovy_chef_jerbs.git', 'master', null, '')

    jerbs.all_the_jerbs()
}