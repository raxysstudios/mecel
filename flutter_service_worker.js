'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "manifest.json": "869465ed816abbb237b72ee328c7c342",
"assets/assets/languages.json": "01a8e7302156342ee2ec2bde4d2c89d8",
"assets/assets/template.json": "08bfcc0a6445e823814a9aac48097fa3",
"assets/assets/flags/kaitag.png": "b3a6bc908348ded647a9498c94fc803d",
"assets/assets/flags/karachay-balkar.png": "285a3e55773e22d866a6fd6b48a7363f",
"assets/assets/flags/ossetian.png": "b90c673b62f0e224da4263d8feb726ca",
"assets/assets/flags/lezgi.png": "f8b20cd884cc8e3bc0c26619b8e2e377",
"assets/assets/flags/dargwa.png": "7f6682b6591817fcbcff42e2d5e46733",
"assets/assets/flags/abkhaz.png": "f786303f7879035d7d0e03fad1f2f2e6",
"assets/assets/flags/circassian.png": "cb90955f12e5bf06f89b003e809f6dbb",
"assets/assets/flags/kumyk.png": "32403e46c893a3d29da221c1ad1d194d",
"assets/assets/languages/east%2520circassian.json": "c8f06ef910d6a03f2f323403c591f0a3",
"assets/assets/languages/karachay-balkar.json": "5fbe0812415d741a34d157c8933b289e",
"assets/assets/languages/kaitag.json": "c3b0d7ed574a861a544eb1f0374f6e8c",
"assets/assets/languages/lezgi.json": "109eb23093dc3bbaff1f917536dbdd06",
"assets/assets/languages/kumyk.json": "ed2e64272aa24e6eea96ea2411911fe5",
"assets/assets/languages/digor.json": "541e1debe8554c752fbfe7ae4f7a51cf",
"assets/assets/languages/iron.json": "d0e56cdcb71f921ed6e624b096643139",
"assets/assets/languages/abkhaz.json": "f6e28b839f1a653e9266e6325ba0fb07",
"assets/assets/languages/dargwa.json": "a4478f6720f4c71b15664b44205a3630",
"assets/assets/raxys.png": "08d218dcf13e53ccb3998541be43c13c",
"assets/NOTICES": "7bea1e3f6c11af4d5c4576fcf24e6f48",
"assets/AssetManifest.json": "fc1651b04a4546de576daed2c42d2d11",
"assets/FontManifest.json": "7b2a36307916a9721811788013e65289",
"assets/fonts/MaterialIcons-Regular.otf": "95db9098c58fd6db106f1116bae85a0b",
"version.json": "dfc1b78c135caf5240e5d3fd7d1376c9",
"flutter.js": "eb2682e33f25cd8f1fc59011497c35f8",
"CNAME": "30c002eb7c2701d4987618aa3c5786e2",
"icons/Icon-512.png": "b595710a09bdcd35d542526992d3a791",
"icons/Icon-192.png": "7155d806ad2f4d6ff9e9d3f9bedce09e",
"canvaskit/canvaskit.wasm": "4b83d89d9fecbea8ca46f2f760c5a9ba",
"canvaskit/canvaskit.js": "c2b4e5f3d7a3d82aed024e7249a78487",
"canvaskit/profiling/canvaskit.wasm": "95e736ab31147d1b2c7b25f11d4c32cd",
"canvaskit/profiling/canvaskit.js": "ae2949af4efc61d28a4a80fffa1db900",
"index.html": "7178b1c4bb0de6d8b2e608cc420b987a",
"/": "7178b1c4bb0de6d8b2e608cc420b987a",
"favicon.png": "48d1b7fc1073342d999bd37b9b0da694",
"main.dart.js": "4c1df9c7d86230509e0c88f7742c73fb"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
