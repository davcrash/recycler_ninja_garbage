# recycler_ninja_garbage

supported platforms

- Android
- iOS
- Web
- Mac
- Windows

## To Play in debug

```
    flutter pub get
    flutter run
```

## To upload to pages

```
    flutter clean
    flutter pub get
    flutter config --enable-web
    flutter build web --web-renderer canvaskit --release --base-href '/recycler_ninja_garbage/'
    cd build/web
    git init
    git status
    git remote add origin https://github.com/davcrash/recycler_ninja_garbage.git
    git checkout -b gh-pages
    git add --all
    git commit -m "new release"
    git push origin gh-pages -f
    cd ../..

```
