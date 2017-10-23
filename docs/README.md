## Directories
The following table summarizes directory contents.

| Directory | Contents Summary |
|:------------- |:----------------- |
| docs | Documents of repository. |
| license | Settings for ``maven-license-plugin``. |
| common | Common scripts and tutorial sources. |
| todo | Scripts and sources to genarate completed Todo Application tutorial. |
| todo-rest | Scripts and sources to genarate completed Todo Application REST tutorial. |
| first-spring-security | Scripts and sources to genarate completed Spring Security tutorial. |

## Shell scripts and Tutorial sources
The following table describe Shell scripts functionality.

| Shell script | Functionality |
|:------------- |:----------------- |
| {tutorial-dir}/scripts/create-app.sh | Root script. Make work-directory and call any sub-scripts. |
| common/scripts/generate-project.sh | Execute ``mvn archetype:generate`` to genarate blank project. Called by ``create-app.sh``. |
| {tutorial-dir}/scripts/copy-sources.sh | Copy any Java source files and some resources. (In tutorial, you need to make each one.) Called by ``create-app.sh``. |
| {tutorial-dir}/scripts/convert-*.sh | Convert files (i.e. append/replace/delete lines) on blank project (or based files). (In tutorial, you need to do manually.) Called by ``create-app.sh`` respectively. |
| common/scripts/convert-*.sh | Convert files (i.e. append/replace/delete lines) on blank project (or based files). (In tutorial, you need to do manually.) Called by ``create-app.sh`` in some tutorials. |
| common/scripts/mvn-singleproject-build.sh | Execute build and test, using ``cargo-maven2-plugin``. For single-project structure. |
| common/scripts/mvn-multiproject-build.sh | Execute build and test, using ``cargo-maven2-plugin``. For multi-project structure. |
| common/scripts/change-maven-settings.sh | Copy maven settings.xml from ``~/.m2`` directory and configure archetype repository. |

## How to execute
You can execute ``change-maven-settings.sh`` and then ``create-app.sh`` with no parameters to genarate tutorial applications.  
First of all, you must set following environment variables.

| Environment Variable | Description | Note |
|:------------- |:----------------- |:----------------- |
| ARCHETYPE_ARTIFACT_ID | Artifact ID of blank project's archetype. | You can choose archetypes from tutorial instructions explained in Development Guideline. |
| ARCHETYPE_VERSION | Version of blank project's archetype. | (e.g. ``5.3.0.RELEASE``) |
| GROUP_ID | Group ID of tutorial project. | You must set to same value as tutorial instructions explained in Development Guideline. |
| ARTIFACT_ID | Artifact ID of tutorial project. | Basically, set to same value as tutorial instructions explained in Development Guideline. |
| VERSION | Version of tutorial project. | Basically, set to same value as tutorial instructions explained in Development Guideline. |
