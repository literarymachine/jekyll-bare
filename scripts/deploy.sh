git clone https://$GITHUB_REPO
cd $(basename ${GITHUB_REPO%.git})
git config user.name "Travis CI"
git config user.email ${EMAIL}
rsync -az --delete --exclude '.git*' ../_site/ .
touch .nojekyll
git add -A .
git commit -m "Generated Jekyll site by Travis CI - ${TRAVIS_BUILD_NUMBER}"
([ "${TRAVIS_BRANCH}" == "master" ] && git push --force --quiet "https://${DEPLOY_KEY}@${GITHUB_REPO}" HEAD:${PRODUCTION_TARGET_BRANCH} > /dev/null 2>&1) || ([ "${TRAVIS_BRANCH}" == "develop" ] && git push --force --quiet "https://${DEPLOY_KEY}@${GITHUB_REPO}" HEAD:${STAGING_TARGET_BRANCH} > /dev/null 2>&1)

