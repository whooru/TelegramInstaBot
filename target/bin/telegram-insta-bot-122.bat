@REM ----------------------------------------------------------------------------
@REM Copyright 2001-2004 The Apache Software Foundation.
@REM
@REM Licensed under the Apache License, Version 2.0 (the "License");
@REM you may not use this file except in compliance with the License.
@REM You may obtain a copy of the License at
@REM
@REM      http://www.apache.org/licenses/LICENSE-2.0
@REM
@REM Unless required by applicable law or agreed to in writing, software
@REM distributed under the License is distributed on an "AS IS" BASIS,
@REM WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
@REM See the License for the specific language governing permissions and
@REM limitations under the License.
@REM ----------------------------------------------------------------------------
@REM

@echo off

set ERROR_CODE=0

:init
@REM Decide how to startup depending on the version of windows

@REM -- Win98ME
if NOT "%OS%"=="Windows_NT" goto Win9xArg

@REM set local scope for the variables with windows NT shell
if "%OS%"=="Windows_NT" @setlocal

@REM -- 4NT shell
if "%eval[2+2]" == "4" goto 4NTArgs

@REM -- Regular WinNT shell
set CMD_LINE_ARGS=%*
goto WinNTGetScriptDir

@REM The 4NT Shell from jp software
:4NTArgs
set CMD_LINE_ARGS=%$
goto WinNTGetScriptDir

:Win9xArg
@REM Slurp the command line arguments.  This loop allows for an unlimited number
@REM of arguments (up to the command line limit, anyway).
set CMD_LINE_ARGS=
:Win9xApp
if %1a==a goto Win9xGetScriptDir
set CMD_LINE_ARGS=%CMD_LINE_ARGS% %1
shift
goto Win9xApp

:Win9xGetScriptDir
set SAVEDIR=%CD%
%0\
cd %0\..\.. 
set BASEDIR=%CD%
cd %SAVEDIR%
set SAVE_DIR=
goto repoSetup

:WinNTGetScriptDir
set BASEDIR=%~dp0\..

:repoSetup


if "%JAVACMD%"=="" set JAVACMD=java

if "%REPO%"=="" set REPO=%BASEDIR%\repo

set CLASSPATH="%BASEDIR%"\etc;"%REPO%"\org\jsoup\jsoup\1.13.1\jsoup-1.13.1.jar;"%REPO%"\org\seleniumhq\selenium\selenium-java\4.0.0-alpha-6\selenium-java-4.0.0-alpha-6.jar;"%REPO%"\org\seleniumhq\selenium\selenium-api\4.0.0-alpha-6\selenium-api-4.0.0-alpha-6.jar;"%REPO%"\org\seleniumhq\selenium\selenium-chrome-driver\4.0.0-alpha-6\selenium-chrome-driver-4.0.0-alpha-6.jar;"%REPO%"\com\google\auto\service\auto-service-annotations\1.0-rc6\auto-service-annotations-1.0-rc6.jar;"%REPO%"\com\google\auto\service\auto-service\1.0-rc6\auto-service-1.0-rc6.jar;"%REPO%"\com\google\auto\auto-common\0.10\auto-common-0.10.jar;"%REPO%"\com\google\guava\guava\29.0-jre\guava-29.0-jre.jar;"%REPO%"\com\google\guava\failureaccess\1.0.1\failureaccess-1.0.1.jar;"%REPO%"\com\google\guava\listenablefuture\9999.0-empty-to-avoid-conflict-with-guava\listenablefuture-9999.0-empty-to-avoid-conflict-with-guava.jar;"%REPO%"\com\google\code\findbugs\jsr305\3.0.2\jsr305-3.0.2.jar;"%REPO%"\org\checkerframework\checker-qual\2.11.1\checker-qual-2.11.1.jar;"%REPO%"\com\google\errorprone\error_prone_annotations\2.3.4\error_prone_annotations-2.3.4.jar;"%REPO%"\com\google\j2objc\j2objc-annotations\1.3\j2objc-annotations-1.3.jar;"%REPO%"\org\seleniumhq\selenium\selenium-chromium-driver\4.0.0-alpha-6\selenium-chromium-driver-4.0.0-alpha-6.jar;"%REPO%"\org\seleniumhq\selenium\selenium-devtools\4.0.0-alpha-6\selenium-devtools-4.0.0-alpha-6.jar;"%REPO%"\org\seleniumhq\selenium\selenium-http\4.0.0-alpha-6\selenium-http-4.0.0-alpha-6.jar;"%REPO%"\org\seleniumhq\selenium\selenium-json\4.0.0-alpha-6\selenium-json-4.0.0-alpha-6.jar;"%REPO%"\org\seleniumhq\selenium\selenium-edge-driver\4.0.0-alpha-6\selenium-edge-driver-4.0.0-alpha-6.jar;"%REPO%"\org\seleniumhq\selenium\selenium-edgehtml-driver\4.0.0-alpha-6\selenium-edgehtml-driver-4.0.0-alpha-6.jar;"%REPO%"\org\seleniumhq\selenium\selenium-firefox-driver\4.0.0-alpha-6\selenium-firefox-driver-4.0.0-alpha-6.jar;"%REPO%"\org\seleniumhq\selenium\selenium-firefox-xpi-driver\4.0.0-alpha-6\selenium-firefox-xpi-driver-4.0.0-alpha-6.jar;"%REPO%"\org\seleniumhq\selenium\selenium-ie-driver\4.0.0-alpha-6\selenium-ie-driver-4.0.0-alpha-6.jar;"%REPO%"\org\seleniumhq\selenium\selenium-opera-driver\4.0.0-alpha-6\selenium-opera-driver-4.0.0-alpha-6.jar;"%REPO%"\org\seleniumhq\selenium\selenium-remote-driver\4.0.0-alpha-6\selenium-remote-driver-4.0.0-alpha-6.jar;"%REPO%"\com\squareup\okhttp3\okhttp\4.5.0\okhttp-4.5.0.jar;"%REPO%"\org\jetbrains\kotlin\kotlin-stdlib\1.3.70\kotlin-stdlib-1.3.70.jar;"%REPO%"\org\jetbrains\annotations\13.0\annotations-13.0.jar;"%REPO%"\com\squareup\okio\okio\2.6.0\okio-2.6.0.jar;"%REPO%"\org\jetbrains\kotlin\kotlin-stdlib-common\1.3.70\kotlin-stdlib-common-1.3.70.jar;"%REPO%"\com\typesafe\netty\netty-reactive-streams\2.0.4\netty-reactive-streams-2.0.4.jar;"%REPO%"\io\netty\netty-handler\4.1.43.Final\netty-handler-4.1.43.Final.jar;"%REPO%"\org\reactivestreams\reactive-streams\1.0.3\reactive-streams-1.0.3.jar;"%REPO%"\io\grpc\grpc-context\1.28.0\grpc-context-1.28.0.jar;"%REPO%"\io\netty\netty-buffer\4.1.49.Final\netty-buffer-4.1.49.Final.jar;"%REPO%"\io\netty\netty-common\4.1.49.Final\netty-common-4.1.49.Final.jar;"%REPO%"\io\netty\netty-codec-http\4.1.49.Final\netty-codec-http-4.1.49.Final.jar;"%REPO%"\io\netty\netty-codec\4.1.49.Final\netty-codec-4.1.49.Final.jar;"%REPO%"\io\netty\netty-transport-native-epoll\4.1.49.Final\netty-transport-native-epoll-4.1.49.Final.jar;"%REPO%"\io\netty\netty-transport-native-epoll\4.1.49.Final\netty-transport-native-epoll-4.1.49.Final-linux-x86_64.jar;"%REPO%"\io\netty\netty-transport-native-kqueue\4.1.49.Final\netty-transport-native-kqueue-4.1.49.Final.jar;"%REPO%"\io\netty\netty-transport-native-kqueue\4.1.49.Final\netty-transport-native-kqueue-4.1.49.Final-osx-x86_64.jar;"%REPO%"\io\netty\netty-transport-native-unix-common\4.1.49.Final\netty-transport-native-unix-common-4.1.49.Final.jar;"%REPO%"\io\netty\netty-transport\4.1.49.Final\netty-transport-4.1.49.Final.jar;"%REPO%"\io\netty\netty-resolver\4.1.49.Final\netty-resolver-4.1.49.Final.jar;"%REPO%"\io\opentelemetry\opentelemetry-api\0.4.0\opentelemetry-api-0.4.0.jar;"%REPO%"\io\opentelemetry\opentelemetry-context-prop\0.4.0\opentelemetry-context-prop-0.4.0.jar;"%REPO%"\io\opentelemetry\opentelemetry-sdk\0.4.0\opentelemetry-sdk-0.4.0.jar;"%REPO%"\io\projectreactor\netty\reactor-netty\0.9.6.RELEASE\reactor-netty-0.9.6.RELEASE.jar;"%REPO%"\io\netty\netty-codec-http2\4.1.48.Final\netty-codec-http2-4.1.48.Final.jar;"%REPO%"\io\netty\netty-handler-proxy\4.1.48.Final\netty-handler-proxy-4.1.48.Final.jar;"%REPO%"\io\projectreactor\reactor-core\3.3.5.RELEASE\reactor-core-3.3.5.RELEASE.jar;"%REPO%"\net\bytebuddy\byte-buddy\1.10.9\byte-buddy-1.10.9.jar;"%REPO%"\org\apache\commons\commons-exec\1.3\commons-exec-1.3.jar;"%REPO%"\org\asynchttpclient\async-http-client\2.12.1\async-http-client-2.12.1.jar;"%REPO%"\org\asynchttpclient\async-http-client-netty-utils\2.12.1\async-http-client-netty-utils-2.12.1.jar;"%REPO%"\io\netty\netty-codec-socks\4.1.48.Final\netty-codec-socks-4.1.48.Final.jar;"%REPO%"\com\sun\activation\javax.activation\1.2.0\javax.activation-1.2.0.jar;"%REPO%"\org\seleniumhq\selenium\selenium-safari-driver\4.0.0-alpha-6\selenium-safari-driver-4.0.0-alpha-6.jar;"%REPO%"\org\seleniumhq\selenium\selenium-support\4.0.0-alpha-6\selenium-support-4.0.0-alpha-6.jar;"%REPO%"\org\telegram\telegrambots\4.9.1\telegrambots-4.9.1.jar;"%REPO%"\org\telegram\telegrambots-meta\4.9.1\telegrambots-meta-4.9.1.jar;"%REPO%"\com\google\inject\guice\4.2.2\guice-4.2.2.jar;"%REPO%"\javax\inject\javax.inject\1\javax.inject-1.jar;"%REPO%"\aopalliance\aopalliance\1.0\aopalliance-1.0.jar;"%REPO%"\com\fasterxml\jackson\core\jackson-annotations\2.10.1\jackson-annotations-2.10.1.jar;"%REPO%"\com\fasterxml\jackson\jaxrs\jackson-jaxrs-json-provider\2.10.1\jackson-jaxrs-json-provider-2.10.1.jar;"%REPO%"\com\fasterxml\jackson\jaxrs\jackson-jaxrs-base\2.10.1\jackson-jaxrs-base-2.10.1.jar;"%REPO%"\com\fasterxml\jackson\module\jackson-module-jaxb-annotations\2.10.1\jackson-module-jaxb-annotations-2.10.1.jar;"%REPO%"\com\fasterxml\jackson\core\jackson-core\2.10.1\jackson-core-2.10.1.jar;"%REPO%"\jakarta\xml\bind\jakarta.xml.bind-api\2.3.2\jakarta.xml.bind-api-2.3.2.jar;"%REPO%"\jakarta\activation\jakarta.activation-api\1.2.1\jakarta.activation-api-1.2.1.jar;"%REPO%"\com\fasterxml\jackson\core\jackson-databind\2.10.1\jackson-databind-2.10.1.jar;"%REPO%"\org\glassfish\jersey\inject\jersey-hk2\2.29.1\jersey-hk2-2.29.1.jar;"%REPO%"\org\glassfish\jersey\core\jersey-common\2.29.1\jersey-common-2.29.1.jar;"%REPO%"\org\glassfish\hk2\osgi-resource-locator\1.0.3\osgi-resource-locator-1.0.3.jar;"%REPO%"\com\sun\activation\jakarta.activation\1.2.1\jakarta.activation-1.2.1.jar;"%REPO%"\org\glassfish\hk2\hk2-locator\2.6.1\hk2-locator-2.6.1.jar;"%REPO%"\org\glassfish\hk2\external\aopalliance-repackaged\2.6.1\aopalliance-repackaged-2.6.1.jar;"%REPO%"\org\glassfish\hk2\hk2-api\2.6.1\hk2-api-2.6.1.jar;"%REPO%"\org\glassfish\hk2\hk2-utils\2.6.1\hk2-utils-2.6.1.jar;"%REPO%"\org\javassist\javassist\3.22.0-CR2\javassist-3.22.0-CR2.jar;"%REPO%"\org\glassfish\jersey\media\jersey-media-json-jackson\2.29.1\jersey-media-json-jackson-2.29.1.jar;"%REPO%"\org\glassfish\jersey\ext\jersey-entity-filtering\2.29.1\jersey-entity-filtering-2.29.1.jar;"%REPO%"\org\glassfish\jersey\containers\jersey-container-grizzly2-http\2.29.1\jersey-container-grizzly2-http-2.29.1.jar;"%REPO%"\org\glassfish\hk2\external\jakarta.inject\2.6.1\jakarta.inject-2.6.1.jar;"%REPO%"\org\glassfish\grizzly\grizzly-http-server\2.4.4\grizzly-http-server-2.4.4.jar;"%REPO%"\org\glassfish\grizzly\grizzly-http\2.4.4\grizzly-http-2.4.4.jar;"%REPO%"\org\glassfish\grizzly\grizzly-framework\2.4.4\grizzly-framework-2.4.4.jar;"%REPO%"\jakarta\ws\rs\jakarta.ws.rs-api\2.1.6\jakarta.ws.rs-api-2.1.6.jar;"%REPO%"\org\glassfish\jersey\core\jersey-server\2.29.1\jersey-server-2.29.1.jar;"%REPO%"\org\glassfish\jersey\core\jersey-client\2.29.1\jersey-client-2.29.1.jar;"%REPO%"\org\glassfish\jersey\media\jersey-media-jaxb\2.29.1\jersey-media-jaxb-2.29.1.jar;"%REPO%"\jakarta\annotation\jakarta.annotation-api\1.3.5\jakarta.annotation-api-1.3.5.jar;"%REPO%"\jakarta\validation\jakarta.validation-api\2.0.2\jakarta.validation-api-2.0.2.jar;"%REPO%"\org\json\json\20180813\json-20180813.jar;"%REPO%"\org\apache\httpcomponents\httpclient\4.5.10\httpclient-4.5.10.jar;"%REPO%"\org\apache\httpcomponents\httpcore\4.4.12\httpcore-4.4.12.jar;"%REPO%"\commons-logging\commons-logging\1.2\commons-logging-1.2.jar;"%REPO%"\commons-codec\commons-codec\1.11\commons-codec-1.11.jar;"%REPO%"\org\apache\httpcomponents\httpmime\4.5.10\httpmime-4.5.10.jar;"%REPO%"\commons-io\commons-io\2.6\commons-io-2.6.jar;"%REPO%"\org\slf4j\slf4j-api\1.7.29\slf4j-api-1.7.29.jar;"%REPO%"\TelegramInstaBot\TelegramInstaBot\1.0-SNAPSHOT\TelegramInstaBot-1.0-SNAPSHOT.jar
set EXTRA_JVM_ARGUMENTS=
goto endInit

@REM Reaching here means variables are defined and arguments have been captured
:endInit

%JAVACMD% %JAVA_OPTS% %EXTRA_JVM_ARGUMENTS% -classpath %CLASSPATH_PREFIX%;%CLASSPATH% -Dapp.name="telegram-insta-bot-122" -Dapp.repo="%REPO%" -Dbasedir="%BASEDIR%" Main %CMD_LINE_ARGS%
if ERRORLEVEL 1 goto error
goto end

:error
if "%OS%"=="Windows_NT" @endlocal
set ERROR_CODE=1

:end
@REM set local scope for the variables with windows NT shell
if "%OS%"=="Windows_NT" goto endNT

@REM For old DOS remove the set variables from ENV - we assume they were not set
@REM before we started - at least we don't leave any baggage around
set CMD_LINE_ARGS=
goto postExec

:endNT
@endlocal

:postExec

if "%FORCE_EXIT_ON_ERROR%" == "on" (
  if %ERROR_CODE% NEQ 0 exit %ERROR_CODE%
)

exit /B %ERROR_CODE%
