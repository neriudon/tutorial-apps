#!/bin/bash
# Convert xml resource(s) on blank project.
# Parameters:
#   $1 : (Optional) Target project path to convert.

TARGET_DIR=$1
if test -n $TARGET_DIR; then
  pushd "${TARGET_DIR}/${ARTIFACT_ID}"
fi

# spring-security.xml
find ./ -type f -name 'spring-security.xml' | xargs sed -i -e 's|<sec:http auto-config="true" use-expressions="true">|\
    <sec:http auto-config="true" use-expressions="true">\
        <sec:form-login login-page="/login/loginForm"\
             authentication-failure-url="/login/loginForm?error=true"\
             login-processing-url="/authenticate" /><!-- (1) -->\
        <sec:logout logout-url="/logout" logout-success-url="/"\
             delete-cookies="JSESSIONID" /><!-- (2) -->\
\
        <sec:intercept-url pattern="/login/**"\
             access="permitAll" /><!-- (3) -->\
        <sec:intercept-url pattern="/**" access="isAuthenticated()" /><!-- (4) -->\
|'

# spring-security.xml
find ./ -type f -name 'spring-security.xml' | xargs sed -i -e 's|<sec:authentication-manager></sec:authentication-manager>|\
    <sec:authentication-manager>\
        <!-- com.example.security.domain.service.userdetails.SampleUserDetails\
             is scaned by component scan with @Service -->\
         <sec:authentication-provider\
             user-service-ref="sampleUserDetailsService"><!-- (5) -->\
             <sec:password-encoder ref="passwordEncoder" /><!-- (6) -->\
         </sec:authentication-provider>\
    </sec:authentication-manager>|'

if test -n $TARGET_DIR; then
  popd
fi
