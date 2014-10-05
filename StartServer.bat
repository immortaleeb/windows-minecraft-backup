SET ServerDir=%1
SET ServerJar=%2
SET World=%3

cd "%ServerDir%"
start "%World%" java -jar %ServerJar%
