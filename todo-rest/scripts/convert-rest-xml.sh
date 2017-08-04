#!/bin/bash
# Convert xml resource(s) on blank project.
# Required variables:
#   ${ARCHETYPE_ARTIFACT_ID}=Artifact ID of blank project's archetype
# Parameters:
#   $1 : (Optional) Target project path to convert.

TARGET_DIR=$1
if test -n $TARGET_DIR; then
  pushd "$TARGET_DIR"
fi

# web.xml
find ./ -type f -name 'web.xml' | xargs sed -i -e 's|<servlet>|\
    <!-- (1) -->\
    <servlet>\
        <servlet-name>restApiServlet</servlet-name>\
        <servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>\
        <init-param>\
            <param-name>contextConfigLocation</param-name>\
            <!-- ApplicationContext for Spring MVC (REST) -->\
            <param-value>classpath*:META-INF/spring/spring-mvc-rest.xml</param-value>\
        </init-param>\
        <load-on-startup>1</load-on-startup>\
    </servlet>\
\
    <!-- (2) -->\
    <servlet-mapping>\
        <servlet-name>restApiServlet</servlet-name>\
        <url-pattern>/api/v1/*</url-pattern>\
    </servlet-mapping>\
\
    <servlet>|'

# spring-mvc-rest.xml
find ./ -type f -name "spring-mvc.xml" -print0 | while read -r -d '' file; do cp -i "$file" "${file%%spring-mvc.xml}spring-mvc-rest.xml"; done

# spring-mvc-rest.xml
find ./ -type f -name 'spring-mvc-rest.xml' | xargs sed -i -e 's|<mvc:argument-resolvers>|\
        <mvc:message-converters>\
            <!-- (2) -->\
            <bean\
                class="org.springframework.http.converter.json.MappingJacksonHttpMessageConverter">\
                <property name="objectMapper" ref="objectMapper"/>\
            </bean>\
        </mvc:message-converters>\
        <mvc:argument-resolvers>|'

# spring-mvc-rest.xml
find ./ -type f -name 'spring-mvc-rest.xml' | xargs sed -i -e 's|</mvc:annotation-driven>|\
    </mvc:annotation-driven>\
\
    <bean id="objectMapper" class="org.codehaus.jackson.map.ObjectMapper">\
        <property name="dateFormat">\
            <!-- (3) -->\
            <bean class="org.codehaus.jackson.map.util.StdDateFormat"/>\
        </property>\
    </bean>\
|'

# spring-mvc-rest.xml
find ./ -type f -name 'spring-mvc-rest.xml' | xargs sed -i -e 's|<context:component-scan base-package="todo.app" />|\
    <context:component-scan base-package="todo.api" />|'

# spring-mvc-rest.xml
if test `echo $ARCHETYPE_ARTIFACT_ID | grep jpa`;then
  find ./ -type f -name 'spring-mvc-rest.xml' | xargs sed -i -e 's|<!--  REMOVE THIS LINE IF YOU USE JPA||'
  find ./ -type f -name 'spring-mvc-rest.xml' | xargs sed -i -e 's|REMOVE THIS LINE IF YOU USE JPA  -->||'
fi

# spring-security,xml
find ./ -type f -name 'spring-security.xml' | xargs sed -i -e 's|<sec:http pattern="/resources/\*\*" security="none"/>|\
    <sec:http pattern="/resources/**" security="none" />\
\
    <!-- (1) -->\
    <sec:http pattern="/api/v1/**" auto-config="true" use-expressions="true" create-session="stateless">\
        <!--<sec:custom-filter ref="csrfFilter" before="LOGOUT_FILTER"/>--> <!-- (2) -->\
        <sec:custom-filter ref="userIdMDCPutFilter" after="ANONYMOUS_FILTER"/>\
        <!--<sec:session-management session-authentication-strategy-ref="sessionAuthenticationStrategy" />--> <!-- (3) -->\
    </sec:http>\
|'

if test -n $TARGET_DIR; then
  popd
fi
