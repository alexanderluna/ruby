# Rails App - Rails 6

A social media site build on Rails 6.

## Rails Asset Pipeline

- `app/assets`: assets specific to the present application
- `lib/assets`: assets for libraries written by your dev team
- `vendor/assets`: assets from third-party vendors (not present by de- fault)

The manifest files tells rails via the sprockets gem how to combine them into a
single file.

```css
/*
*= require_tree .
*= require_self
*/
```

The first line, includes all the files in the directory. The second line,
specifies where in the loading sequence the `application.css` file itself gets
included.
