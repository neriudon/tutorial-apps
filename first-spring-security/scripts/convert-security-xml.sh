#!/bin/bash
# Convert xml resource(s) on blank project.
# Parameters:
#   $1 : (Optional) Target project path to convert.

TARGET_DIR=$1
if test -n $TARGET_DIR; then
  pushd "$TARGET_DIR"
fi

# spring-security.xml
find ./ -type f -name 'spring-security.xml' | xargs sed -i -e 's|</sec:http>|\
        <!-- (1) -->\
        <sec:form-login\
            login-page="/login.jsp"\
            authentication-failure-url="/login.jsp?error=true"\
            login-processing-url="/authenticate" />\
        <!-- (2) -->\
        <sec:logout\
            logout-url="/logout"\
            logout-success-url="/"\
            delete-cookies="JSESSIONID" />\
        <!-- (3) -->\
        <sec:intercept-url pattern="/login.jsp" access="permitAll" />\
        <sec:intercept-url pattern="/**" access="isAuthenticated()" />\
    </sec:http>|'

# spring-security.xml
find ./ -type f -name 'spring-security.xml' | xargs sed -i -e 's|<sec:authentication-manager></sec:authentication-manager>|\
    <sec:authentication-manager>\
        <!-- com.example.security.domain.service.userdetails.SampleUserDetailsService \
            is scanned by component scan with @Service -->\
        <!-- (4) -->\
        <sec:authentication-provider\
            user-service-ref="sampleUserDetailsService">\
            <!-- (5) -->\
            <sec:password-encoder ref="passwordEncoder" />\
        </sec:authentication-provider>\
    </sec:authentication-manager>|'

if test -n $TARGET_DIR; then
  popd
fi
