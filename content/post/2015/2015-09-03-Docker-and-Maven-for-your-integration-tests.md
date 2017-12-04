---
author:
  email: adrien.lecharpentier@gmail.com
  name: Adrien Lecharpentier
date: 2015-09-03T00:00:00Z
tags: docker maven integration-tests
title: Docker and Maven for your integration tests
url: /2015/09/03/Docker-and-Maven-for-your-integration-tests/
---

In the last weeks, I've been working on a side project to share pictures easily, outside of _Face de bouc_, as my mom used to say. But this is not the point. As a bad developer, I started quickly and so dirty: no tests of any kind. Then a friend came and offered some changes. Tests were needed.

## Do your tests, damn it!
So first, I did some tests. The PR was about database insert in batch rather than in a `Stream`. So, I did my _unit-tests_ (I'll talk about that later), using HSQLDB in memory. I didn't choose `H2`, which I know, because I didn't find the `Dialect` in the database connector I'm using in the project: Dalesbred.

> I could have used `H2` directly as, even if there is no dialect for it in Dalesbred, it doesn't really matter. I learned that after.

## If you test, do it correctly!
So, another mistake: those are no __unit tests__ but __integration tests__! I'm validating the integration of my `EventRepository` to a database.

How to change that? Easy: don't use `maven-surefire-plugin` but `maven-failsafe-plugin`. The first one is automatically linked to your Maven lifecycle while the last one needs to be configured. I don't know why, I asked a Maven Contributor, this could be part of another post.

The configuration is quite easy:

```xml
<plugin>
  <groupId>org.apache.maven.plugins</groupId>
  <artifactId>maven-failsafe-plugin</artifactId>
  <version>2.18.1</version>
  <executions>
    <execution>
      <id>integration-tests</id>
      <goals>
        <goal>integration-test</goal>
      </goals>
    </execution>
      <execution>
        <id>verify</id>
        <goals>
          <goal>verify</goal>
        </goals>
      </execution>
  </executions>
</plugin>
```

One last thing: change the `EventRepositoryTest` to `EventRepositoryIT`. `*IT` is the default pattern used by the `maven-failsafe-plugin` to find integration tests and execute them.

## And docker in this mess?
At this point, I was still using HSQLDB, but I changed something in my database schema: I wanted to change the foreign key of `event_picture` to `pictures.id` table to delete the link between `events` and `pictures` automatically. So I had:

```sql
ALTER TABLE event_picture
    DROP CONSTRAINT event_picture_id_picture_fkey,
    ADD CONSTRAINT event_picture_id_picture_fkey
      FOREIGN KEY (id_picture) REFERENCES pictures(id) ON DELETE CASCADE;
```

But I didn't find a way to make HSQLDB understand the constraint name. Maybe I didn't look well enough. But, at this moment I realized that I was testing some database that might not be compatible. However, it is not possible to have a in-memory PostgreSQL.

Docker is here to save me/us!

## Use Docker to have the correct database
From day-1, I decided that I would use Docker for this project. It is not deployed as a `war` on Tomcat, but as a executable `jar` inside a image. So using a Docker image for my integration tests was not a difficult decision to make. Choosing the Maven plugin was much more difficult!

I finally found `org.jolokia:docker-maven-plugin`. At that moment, I had a very limited usage of this plugin. But, I didn't want to build my image using the Maven plugin, I wanted to be able to run a random image. By random, I mean one that would start the database I was using for my project.

> I believe that Maven is in charge to build my project, but not to deliver it. It can put it in a Maven Repository Manager but not further. The parallel example is: Maven for Continuous Integration lifecycle, for the Continuous Delivery lifecycle it's something else.

Based on that, I saw I was able to configure the plugin to start a container, using a specific image, provide some configuration to this image. So my configuration looks like:

```xml
<plugin>
  <groupId>org.jolokia</groupId>
  <artifactId>docker-maven-plugin</artifactId>
  <version>0.13.3</version>
  <configuration>
    <images>
      <image>
        <name>postgres:9.4</name>
        <run>
          <ports>
            <port>5432:5432</port>
          </ports>
          <wait>
            <time>2000</time>
          </wait>
        </run>
      </image>
    </images>
  </configuration>
  <executions>
    <execution>
      <id>pre-integration-test</id>
      <phase>pre-integration-test</phase>
      <goals>
        <goal>start</goal>
      </goals>
    </execution>
    <execution>
      <id>post-integration-test</id>
      <phase>post-integration-test</phase>
      <goals>
        <goal>stop</goal>
      </goals>
    </execution>
  </executions>
</plugin>
```

So, easy description: in the `<executions/>`, I start the container before the integration tests and stop it after. In the `<configuration/>`, I declare which image I want to use, what is the port for the mapping I'm doing. In the `<wait/>`, I could even declare a `<url/>` to watch, and until the plugin sees it's available, it blocks the build process. As I don't know any PostgreSQL URL to ping to see if the database is up and running, I used a random time to block the build, 2 seconds seemed to be enough here.

In the plugin description site, they show you that you can wait until your application is up and running before starting all your integration tests. That could be very good on my project if I want to do some full stack integration tests. I'm not there yet.

## And then?
This could be used to test my `EventRepository` against any database (available as a Docker image) if I wanted to be able to use another database. I don't see the need for me, but I know many projects that use H2 as an embedded database, but offer you the choose to change it to any MySQL, PostgreSQL or Oracle database.

I also discovered that in my integration tests I was expecting some `SQLIntegrityConstraintViolationException` exception when saving to identical objects. But PostgreSQL driver seems to return a more generic exception: `PSQLException`. So why do we bother to have a `java.sql` package in the JDK/JRE?

Thanks for reading, see you on next post.

## Links
 - Dalesbred: http://dalesbred.org/
 - docker-maven-plugin: https://github.com/rhuss/docker-maven-plugin
 - my side project: https://github.com/alecharp/PicShare
