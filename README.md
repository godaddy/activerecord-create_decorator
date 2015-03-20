# ActiveRecord::CreateDecorator

Modifies table creation done through ActiveRecord to allow you to specify connection-specific table options.  Technically you can do this within your migrations by passing along an options hash, but that requires you to introduce adapter-specific logic in those migrations if you want to support different database providers, along with switching to the sql-based schema dumper.  With this your migrations remain adapter-agnostic and you can continue to make use of schema.rb.  Obviously, this won't help you if you're doing other DB-specific stuff like stored procedures or whatever, but it works great for setting a default row_format in mysql.

## Installation

Add the following to your gemfile.  The later the better, to avoid any sort of weird interactions with other things
that might be messing with your connection handling (Apartment, I'm looking at you)

`gem 'activerecord-create_decorator'`

## Usage

Simply add a create_options attribute within your database.yml related to the specific connection you want to modify, e.g.

```
development:
  adapter: mysql2
  encoding: utf8mb4
  collation: utf8mb4_unicode_ci
  reconnect: true
  database: my_database
  pool: 5
  username: someuser
  password: somepassword
  host: 127.0.0.1
  port: 3306
  create_options: 'DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC'
```

Any table creates that operate through that connection will have the options specified merged into existing options.

