Active Admin latitude and longitude plugin



## Getting started

```ruby
gem 'activeadmin_latlng'
```

```ruby
form do |f|
  f.inputs do
    f.input :lat
    f.input :lng
    f.latlng lang: :ru
  end
  f.actions
end
```



## Settings

* `lang` - language, `ru` by default

* `map` - map provider, yandex maps by default

* `id_lat` and `id_lng` - identificator of latitude and longitude inputs, Moscow coords by default

* `height` - map height in pixels, 400 by default



## Contributors

Alexey Krylov

## License

MIT License. Copyright 2016 Alexey Krylov