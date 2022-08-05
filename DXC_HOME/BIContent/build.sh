#! /bin/sh

CLASSPATH=; export CLASSPATH

if [ -f "../SetEnvironment.sh" ]; then
  . ../SetEnvironment.sh
fi

BI_BUILDFILE=./build.xml; export BI_BUILDFILE

if [ -z "$ANT_OPTS" ]; then
  ANT_OPTS="-Xmx512m -Xbootclasspath/p:$CURAMCDEJ/lib/ext/jar/serializer.jar:$CURAMCDEJ/lib/ext/jar/xercesImpl.jar:$CURAMCDEJ/lib/ext/jar/xalan.jar"; export ANT_OPTS
else
  ANT_OPTS="$ANT_OPTS -Xmx512m -Xbootclasspath/p:$CURAMCDEJ/lib/ext/jar/serializer.jar:$CURAMCDEJ/lib/ext/jar/xercesImpl.jar:$CURAMCDEJ/lib/ext/jar/xalan.jar"; export ANT_OPTS
fi

ant -f $BI_BUILDFILE $@
