java:
  pkgs:
    # Android development doesn't support higher than version 19, (current at time of writing 12/7/23 was version 21), next oldest version in gentoo was 17
    # Android development is bounded by not supporting higher than Gradle 7.6.1 which supports version 19 https://docs.gradle.org/current/userguide/compatibility.html
    - dev-java/openjdk-bin: 17.0.8.1_p1
    - dev-java/openjdk-jre-bin: 17.0.8.1_p1

  java_home: /usr/lib/jvm/openjdk-bin-17/