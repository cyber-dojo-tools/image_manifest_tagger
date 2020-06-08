#!/usr/bin/env ruby
#coding:utf-8

require 'json'

tag = ARGV[0]
manifest_filename = '/start_point/manifest.json'
json = IO.read(manifest_filename)
manifest = JSON.parse(json)
print manifest['image_name'].sub('cyberdojofoundation', 'cyberdojostartpoints')
manifest['image_name'] += ":#{tag}"
IO.write(manifest_filename, JSON.pretty_generate(manifest))
