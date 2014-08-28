# Datastax Ruby Driver for Apache Cassandra

A Ruby client driver for Apache Cassandra. This driver works exclusively with
the Cassandra Query Language version 3 (CQL3) and Cassandra's native protocol.

- Docs: http://datastax.github.io/ruby-driver/
- JIRA: https://datastax-oss.atlassian.net/browse/RUBY
- MAILING LIST: https://groups.google.com/a/lists.datastax.com/forum/#!forum/ruby-driver-user
- IRC: #datastax-drivers on [irc.freenode.net](http://freenode.net>)
- TWITTER: Follow the latest news about DataStax Drivers - [@avalanche123](http://twitter.com/avalanche123), [@mfiguiere](http://twitter.com/mfiguiere), [@al3xandru](https://twitter.com/al3xandru) 

This driver is based on [the cql-rb gem](https://github.com/iconara/cql-rb) by [Theo Hultberg](https://github.com/iconara) and we addded support for:

* [asynchronous execution](/features/asynchronous_io/)
* one-off, [prepared](/features/prepared_statements/) and [batch statements](/features/batch_statements/)
* automatic peer discovery and cluster metadata
* various [load-balancing](/features/load_balancing/), [retry](/features/retry_policies/) and reconnection policies, [with ability to write your own](/features/load_balancing/implementing_a_policy/)

## Compability

This driver works exclusively with the Cassandra Query Language v3 (CQL3) and Cassandra's native protocol. The current version works with:

*   Cassandra versions 1.2 and 2.0
*   Ruby 1.9.3 and 2.0
*   JRuby 1.7

    _Note_: JRuby 1.6 is not officially supported, although 1.6.8 should work.

*   Rubinius 2.1



## Quick start

```ruby
require 'cassandra'

cluster = Cassandra.connect # connects to localhost by default

cluster.each_hosts do |host| # automatically discovers all peers
  puts "Host #{host.ip}: id=#{host.id} datacenter=#{host.datacenter} rack=#{host.rack}"
end

keyspace = 'system'
session  = cluster.connect(keyspace) # create session, optionally scoped to a keyspace, to execute queries

future = session.execute_async('SELECT keyspace_name, columnfamily_name FROM schema_columnfamilies') # fully asynchronous api
future.on_success do |rows|
  rows.each do |row|
    puts "The keyspace #{row['keyspace_name']} has a table called #{row['columnfamily_name']}"
  end
end
future.join
```

The host you specify is just a seed node, the driver will automatically discover all peers in the cluster.

Read more:

* [`Cql.connect` options](/api/#connect-class_method)
* [`Session#execute_async` options](/api/session/#execute_async-instance_method)
* [Usage documentation](/features)

## Upgrading from cql-rb

Some of the new features added to the driver have unfortunately led to changes in the original cql-rb API. In the examples directory, you can find [an example of how to wrap the ruby driver to achieve almost complete interface parity with cql-rb](https://github.com/datastax/ruby-driver/blob/master/examples/cql-rb-wrapper.rb) to assist you with gradual upgrade.

## Changelog & versioning

Check out the [releases on GitHub](https://github.com/datastax/ruby-driver/releases). Version numbering follows the [semantic versioning](http://semver.org/) scheme.

Private and experimental APIs, defined as whatever is not in the [public API documentation][1], i.e. classes and methods marked as `@private`, will change without warning. If you've been recommended to try an experimental API by the maintainers, please let them know if you depend on that API. Experimental APIs will eventually become public, and knowing how they are used helps in determining their maturity.

Prereleases will be stable, in the sense that they will have finished and properly tested features only, but may introduce APIs that will change before the final release. Please use the prereleases and report bugs, but don't deploy them to production without consulting the maintainers, or doing extensive testing yourself. If you do deploy to production please let the maintainers know as this helps determining the maturity of the release.

## Known bugs & limitations

* JRuby 1.6 is not officially supported, although 1.6.8 should work, if you're stuck in JRuby 1.6.8 try and see if it works for you.
* Because the driver reactor is using `IO.select`, the maximum number of tcp connections allowed is 1024.


## Credits

This driver is based on the original work of [Theo Hultberg](https://github.com/iconara) on [cql-rb](https://github.com/iconara/cql-rb/) and adds a series of advanced features that are common across all other DataStax drivers for Apache Cassandra.

The development effort to provide an up to date, high performance, fully featured Ruby Driver for Apache Cassandra will continue on this project, while [cql-rb](https://github.com/iconara/cql-rb/) will be discontinued. 


## Copyright

Copyright 2013-2014 DataStax, Inc.

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

[http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.

  [1]: http://datastax.github.io/ruby-driver/api
