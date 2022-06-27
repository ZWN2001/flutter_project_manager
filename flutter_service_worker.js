'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "favicon.png": "5dcef449791fa27946b3d35ad8803796",
"canvaskit/canvaskit.js": "c2b4e5f3d7a3d82aed024e7249a78487",
"canvaskit/profiling/canvaskit.js": "ae2949af4efc61d28a4a80fffa1db900",
"canvaskit/profiling/canvaskit.wasm": "95e736ab31147d1b2c7b25f11d4c32cd",
"canvaskit/canvaskit.wasm": "4b83d89d9fecbea8ca46f2f760c5a9ba",
"index.html": "b612b31237ca1041abffc6eee0a515a7",
"/": "455d66f41ebd11c0078f6b516e9e9b9b",
"flutter.js": "eb2682e33f25cd8f1fc59011497c35f8",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"web_release/web/favicon.png": "5dcef449791fa27946b3d35ad8803796",
"web_release/web/canvaskit/canvaskit.js": "43fa9e17039a625450b6aba93baf521e",
"web_release/web/canvaskit/profiling/canvaskit.js": "f3bfccc993a1e0bfdd3440af60d99df4",
"web_release/web/canvaskit/profiling/canvaskit.wasm": "a9610cf39260f60fbe7524a785c66101",
"web_release/web/canvaskit/canvaskit.wasm": "04ed3c745ff1dee16504be01f9623498",
"web_release/web/index.html": "455d66f41ebd11c0078f6b516e9e9b9b",
"web_release/web/icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"web_release/web/icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"web_release/web/manifest.json": "df8ee12e5d40a884cc23acd0588bda1c",
"web_release/web/version.json": "e9eb58db72d407be27e9fa052224c304",
"web_release/web/assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"web_release/web/assets/fonts/MaterialIcons-Regular.otf": "4e6447691c9509f7acdbf8a931a85ca1",
"web_release/web/assets/AssetManifest.json": "73553807419ba0e668ac8231cd32d9cc",
"web_release/web/assets/assets/images/taskCardBackgroundImage.png": "b323c5a92cbb8f8fafeb117c359f61bd",
"web_release/web/assets/assets/images/lzw_img.png": "d1608a9e1e50339e45b410d883c5df8a",
"web_release/web/assets/assets/images/login_logo.png": "7bea9b70b76ef2d2ff9784c88b328337",
"web_release/web/assets/assets/images/profile_pic.png": "5f56c3070f1c066ae15ecad12fb44f54",
"web_release/web/assets/assets/images/logo.png": "1cc52e1222e83c820cb5d9b2507a5705",
"web_release/web/assets/assets/icons/Search.svg": "396d519c18918ed763d741f4ba90243a",
"web_release/web/assets/assets/icons/menu_tran.svg": "6c95fa7ae6679737dc57efd2ccbb0e57",
"web_release/web/assets/assets/icons/menu_add_demand.svg": "a6985c6d013353f8cc59260532e935bc",
"web_release/web/assets/assets/icons/demand_created.svg": "b8ce3a647dc4d821578ee36876523220",
"web_release/web/assets/assets/icons/media_file.svg": "2ac15c968f8a8cea571a0f3e9f238a66",
"web_release/web/assets/assets/icons/menu_notification.svg": "460268d6e4bdeab56538d7020cc4b326",
"web_release/web/assets/assets/icons/right_arrow.svg": "d681ce7d497531a9559ea82b7e12e8f3",
"web_release/web/assets/assets/icons/logo.svg": "b3af0c077a73709c992d7e075b76ce33",
"web_release/web/assets/assets/icons/google_drive.svg": "9a3005a58d47a11bfeffc11ddd3567c1",
"web_release/web/assets/assets/icons/demand_finished.svg": "30cfd39354cd00750eb0dd2cc3da9f0e",
"web_release/web/assets/assets/icons/doc_file.svg": "552a02a5a3dbaee682de14573f0ca9f3",
"web_release/web/assets/assets/icons/unknown.svg": "b2f3cdc507252d75dea079282f14614f",
"web_release/web/assets/assets/icons/excle_file.svg": "dc91b258ecf87f5731fb2ab9ae15a3ec",
"web_release/web/assets/assets/icons/Documents.svg": "51896b51d35e28711cf4bd218bde185d",
"web_release/web/assets/assets/icons/menu_profile.svg": "fe56f998a7c1b307809ea3653a1b62f9",
"web_release/web/assets/assets/icons/sound_file.svg": "fe212d5edfddd0786319edf50601ec73",
"web_release/web/assets/assets/icons/menu_store.svg": "2fd4ae47fd0fca084e50a600dda008cd",
"web_release/web/assets/assets/icons/demand_doing.svg": "1206fe6cf712dba77a74ea0116a60a4b",
"web_release/web/assets/assets/icons/menu_dashboard.svg": "b2cdf62e9ce9ca35f3fc72f1c1fcc7d4",
"web_release/web/assets/assets/icons/Figma_file.svg": "0ae328b79325e7615054aed3147c81f9",
"web_release/web/assets/assets/icons/empty_content.svg": "fd425117d37b2a71fe4a086f749943da",
"web_release/web/assets/assets/icons/media.svg": "059dfe46bd2d92e30bf361c2f7055c3b",
"web_release/web/assets/assets/icons/demand_overtime.svg": "cb37d343ed25bd9778770c0ef2f3ff9b",
"web_release/web/assets/assets/icons/xd_file.svg": "38913b108e39bcd55988050d2d80194c",
"web_release/web/assets/assets/icons/menu_task.svg": "1a02d1c14f49a765da34487d23a3093b",
"web_release/web/assets/assets/icons/drop_box.svg": "3295157e194179743d6093de9f1ff254",
"web_release/web/assets/assets/icons/one_drive.svg": "aa908c0a29eb795606799385cdfc8592",
"web_release/web/assets/assets/icons/menu_doc.svg": "09673c2879de2db9646345011dbaa7bb",
"web_release/web/assets/assets/icons/menu_setting.svg": "d0e24d5d0956729e0e2ab09cb4327e32",
"web_release/web/assets/assets/icons/menu_developing.svg": "2cdb7c879beb2b1af6d236edea695120",
"web_release/web/assets/assets/icons/pdf_file.svg": "ca854643eeee7bedba7a1d550e2ba94f",
"web_release/web/assets/assets/icons/demand_fail.svg": "2f20ed151cdcb4871057ca67f0a0b847",
"web_release/web/assets/assets/icons/demand_rejected.svg": "de5c88bc30846c017c2edf14fae65189",
"web_release/web/assets/assets/icons/folder.svg": "40a82e74e930ac73aa6ccb85d8c5a29c",
"web_release/web/assets/packages/fluttertoast/assets/toastify.css": "a85675050054f179444bc5ad70ffc635",
"web_release/web/assets/packages/fluttertoast/assets/toastify.js": "e7006a0a033d834ef9414d48db3be6fc",
"web_release/web/assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"web_release/web/assets/NOTICES": "1e68f467d9dd603bb727abda4053a63d",
"web_release/web/main.dart.js": "801d0ce3cca1266e8ee88028d30c1a12",
"manifest.json": "df8ee12e5d40a884cc23acd0588bda1c",
"version.json": "e9eb58db72d407be27e9fa052224c304",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "95db9098c58fd6db106f1116bae85a0b",
"assets/AssetManifest.json": "73553807419ba0e668ac8231cd32d9cc",
"assets/assets/images/taskCardBackgroundImage.png": "b323c5a92cbb8f8fafeb117c359f61bd",
"assets/assets/images/lzw_img.png": "d1608a9e1e50339e45b410d883c5df8a",
"assets/assets/images/login_logo.png": "7bea9b70b76ef2d2ff9784c88b328337",
"assets/assets/images/profile_pic.png": "5f56c3070f1c066ae15ecad12fb44f54",
"assets/assets/images/logo.png": "1cc52e1222e83c820cb5d9b2507a5705",
"assets/assets/icons/Search.svg": "396d519c18918ed763d741f4ba90243a",
"assets/assets/icons/menu_tran.svg": "6c95fa7ae6679737dc57efd2ccbb0e57",
"assets/assets/icons/menu_add_demand.svg": "a6985c6d013353f8cc59260532e935bc",
"assets/assets/icons/demand_created.svg": "b8ce3a647dc4d821578ee36876523220",
"assets/assets/icons/media_file.svg": "2ac15c968f8a8cea571a0f3e9f238a66",
"assets/assets/icons/menu_notification.svg": "460268d6e4bdeab56538d7020cc4b326",
"assets/assets/icons/right_arrow.svg": "d681ce7d497531a9559ea82b7e12e8f3",
"assets/assets/icons/logo.svg": "b3af0c077a73709c992d7e075b76ce33",
"assets/assets/icons/google_drive.svg": "9a3005a58d47a11bfeffc11ddd3567c1",
"assets/assets/icons/demand_finished.svg": "30cfd39354cd00750eb0dd2cc3da9f0e",
"assets/assets/icons/doc_file.svg": "552a02a5a3dbaee682de14573f0ca9f3",
"assets/assets/icons/unknown.svg": "b2f3cdc507252d75dea079282f14614f",
"assets/assets/icons/excle_file.svg": "dc91b258ecf87f5731fb2ab9ae15a3ec",
"assets/assets/icons/Documents.svg": "51896b51d35e28711cf4bd218bde185d",
"assets/assets/icons/menu_profile.svg": "fe56f998a7c1b307809ea3653a1b62f9",
"assets/assets/icons/sound_file.svg": "fe212d5edfddd0786319edf50601ec73",
"assets/assets/icons/menu_store.svg": "2fd4ae47fd0fca084e50a600dda008cd",
"assets/assets/icons/demand_doing.svg": "1206fe6cf712dba77a74ea0116a60a4b",
"assets/assets/icons/menu_dashboard.svg": "b2cdf62e9ce9ca35f3fc72f1c1fcc7d4",
"assets/assets/icons/Figma_file.svg": "0ae328b79325e7615054aed3147c81f9",
"assets/assets/icons/empty_content.svg": "fd425117d37b2a71fe4a086f749943da",
"assets/assets/icons/media.svg": "059dfe46bd2d92e30bf361c2f7055c3b",
"assets/assets/icons/demand_overtime.svg": "cb37d343ed25bd9778770c0ef2f3ff9b",
"assets/assets/icons/xd_file.svg": "38913b108e39bcd55988050d2d80194c",
"assets/assets/icons/menu_task.svg": "1a02d1c14f49a765da34487d23a3093b",
"assets/assets/icons/drop_box.svg": "3295157e194179743d6093de9f1ff254",
"assets/assets/icons/one_drive.svg": "aa908c0a29eb795606799385cdfc8592",
"assets/assets/icons/menu_doc.svg": "09673c2879de2db9646345011dbaa7bb",
"assets/assets/icons/menu_setting.svg": "d0e24d5d0956729e0e2ab09cb4327e32",
"assets/assets/icons/menu_developing.svg": "2cdb7c879beb2b1af6d236edea695120",
"assets/assets/icons/pdf_file.svg": "ca854643eeee7bedba7a1d550e2ba94f",
"assets/assets/icons/demand_fail.svg": "2f20ed151cdcb4871057ca67f0a0b847",
"assets/assets/icons/demand_rejected.svg": "de5c88bc30846c017c2edf14fae65189",
"assets/assets/icons/folder.svg": "40a82e74e930ac73aa6ccb85d8c5a29c",
"assets/packages/fluttertoast/assets/toastify.css": "a85675050054f179444bc5ad70ffc635",
"assets/packages/fluttertoast/assets/toastify.js": "e7006a0a033d834ef9414d48db3be6fc",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/NOTICES": "f6766aeb7400917c7e888000305dd5cc",
"main.dart.js": "aada37fb7ef3bf05884592e0a67c523f"
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
