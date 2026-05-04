'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {".git/COMMIT_EDITMSG": "9ccb8a05d08be23e67b34458880c105f",
".git/config": "96abdb1b93ea70bf5ab7e84690d879f9",
".git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
".git/HEAD": "5ab7a4355e4c959b0c5c008f202f51ec",
".git/hooks/applypatch-msg.sample": "ce562e08d8098926a3862fc6e7905199",
".git/hooks/commit-msg.sample": "579a3c1e12a1e74a98169175fb913012",
".git/hooks/fsmonitor-watchman.sample": "a0b2633a2c8e97501610bd3f73da66fc",
".git/hooks/post-update.sample": "2b7ea5cee3c49ff53d41e00785eb974c",
".git/hooks/pre-applypatch.sample": "054f9ffb8bfe04a599751cc757226dda",
".git/hooks/pre-commit.sample": "5029bfab85b1c39281aa9697379ea444",
".git/hooks/pre-merge-commit.sample": "39cb268e2a85d436b9eb6f47614c3cbc",
".git/hooks/pre-push.sample": "2c642152299a94e05ea26eae11993b13",
".git/hooks/pre-rebase.sample": "56e45f2bcbc8226d2b4200f7c46371bf",
".git/hooks/pre-receive.sample": "2ad18ec82c20af7b5926ed9cea6aeedd",
".git/hooks/prepare-commit-msg.sample": "2b5c047bdb474555e1787db32b2d2fc5",
".git/hooks/push-to-checkout.sample": "c7ab00c7784efeadad3ae9b228d4b4db",
".git/hooks/sendemail-validate.sample": "4d67df3a8d5c98cb8565c07e42be0b04",
".git/hooks/update.sample": "647ae13c682f7827c22f5fc08a03674e",
".git/index": "43794f606f596cfaa8e62e994d267a87",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/logs/HEAD": "ee1209272067099c3f30aae35b0c800f",
".git/logs/refs/heads/gh-pages": "de4ac1dbf1e4a0eb418d765b3a147954",
".git/logs/refs/remotes/origin/gh-pages": "9ab59af10be875e508bdbed5a3e7b890",
".git/objects/02/1d4f3579879a4ac147edbbd8ac2d91e2bc7323": "9e9721befbee4797263ad5370cd904ff",
".git/objects/0a/fd7f03cafb64298fc9f2df4e20300a4619e700": "d34d9a834c4caca971d5932b415973ef",
".git/objects/16/9dc34e434ebec00e7f25747124db31e15f85b4": "b02d35fec9372402e020c0295c57b8c8",
".git/objects/20/3a3ff5cc524ede7e585dff54454bd63a1b0f36": "4b23a88a964550066839c18c1b5c461e",
".git/objects/22/7a6e49797b306414fb7d2c9166e85a22467bb9": "cc29ffbb3a11392cc41a0a02ecd5a78a",
".git/objects/26/0ccf0608590d5775e9627ea9a1ec67d4a05276": "dc56f3b456d0e151f0a8c1584f253ed3",
".git/objects/29/f22f56f0c9903bf90b2a78ef505b36d89a9725": "e85914d97d264694217ae7558d414e81",
".git/objects/2e/9cbcbfed4da38a91031e8a38a3439468ff822f": "63e4ef5b01e927051a097e0f9a05b2fe",
".git/objects/3a/bf18c41c58c933308c244a875bf383856e103e": "30790d31a35e3622fd7b3849c9bf1894",
".git/objects/3d/23ef36742b9311511b6a4947414a87687d1865": "d437b09e403526e17810a1403ded2c32",
".git/objects/43/a48ac1b2d0f661ff3681736cc8a8eb9de7f847": "af6e6919f186fbf1c73453ca75b82511",
".git/objects/48/820c0b4b85a2e32e061897c7713300ef0d68a4": "a941358b6a898c55a766223627cf9371",
".git/objects/4a/2db9f11a4087dbc45e82b304238dd379a5856e": "cea24c9e26a86b863468cea7d3b92847",
".git/objects/4b/135ba2c445e52a84d9cee7f8e90347fa184775": "4f4c4ec8461fcf9335fe404c566634c1",
".git/objects/4b/dd98c84b838e69565fe2f58ee73a89bf6e8759": "08fb457eda30d21c735987d707bf7510",
".git/objects/4d/bf9da7bcce5387354fe394985b98ebae39df43": "534c022f4a0845274cbd61ff6c9c9c33",
".git/objects/4f/83d31f920fcb428aeb4d1d9a5ecb7aa1548119": "4a5fbfe5ff35a797833a10fd98945a7a",
".git/objects/4f/fbe6ec4693664cb4ff395edf3d949bd4607391": "2beb9ca6c799e0ff64e0ad79f9e55e69",
".git/objects/57/9d1f77dd51808f620a78550ebce6d94b8422b4": "329697fa90112bb534b8e57f6af6246b",
".git/objects/57/adc034bb15cd729259033bbc5fdba60c22b001": "216bc379b894083f8e0d98807f8d01d7",
".git/objects/5b/85b254f01860837e6a48597fd0019db5717253": "d6b832e8bfcd23056618faa0f83216fa",
".git/objects/5f/07e8a9e6f0083ff32b42f3f3071e6b674617ed": "dba83f51ef2a598043cf7631504727ac",
".git/objects/5f/f4cbf99a067537efbdd5d5e2541b76606441bf": "abd4c2853900ca19bb7d75b147315710",
".git/objects/62/e41d7d5560b09a29fad88a19b86095c00583e9": "9fc68d77f96e6e6559a4cbbb24654e90",
".git/objects/68/6c29a32e0066bbb01c55c0578163a37d0f8d1b": "24d40700d32560a9ea00e533d06403dd",
".git/objects/7a/6c1911dddaea52e2dbffc15e45e428ec9a9915": "f1dee6885dc6f71f357a8e825bda0286",
".git/objects/7a/746981ffe35a2dcd75010ba21c4bcf8a8d04bc": "8847d55692f0e259690a92243b07021d",
".git/objects/7d/6b72ba1a7a455639c93bdfd0497253b03dc65f": "11100622065b5d7197850934012cf881",
".git/objects/88/cfd48dff1169879ba46840804b412fe02fefd6": "e42aaae6a4cbfbc9f6326f1fa9e3380c",
".git/objects/8a/aa46ac1ae21512746f852a42ba87e4165dfdd1": "1d8820d345e38b30de033aa4b5a23e7b",
".git/objects/8a/b5a0f4beca374c4a5bef911254f381ce73c017": "2bfe38dc2b4cf6e8043e42087015690c",
".git/objects/98/0d49437042d93ffa850a60d02cef584a35a85c": "8e18e4c1b6c83800103ff097cc222444",
".git/objects/9b/3ef5f169177a64f91eafe11e52b58c60db3df2": "91d370e4f73d42e0a622f3e44af9e7b1",
".git/objects/9e/0cfefc580f82b7099856411e91a2ff3bd35386": "5d4121e38eb3719fffdb329fc7726f90",
".git/objects/9e/3b4630b3b8461ff43c272714e00bb47942263e": "accf36d08c0545fa02199021e5902d52",
".git/objects/a5/cb415d8f4c804efa1de88b529b95bb7459b6b5": "2a5d5d3742ef7942bd0519addf464c4d",
".git/objects/b0/d7fbec113e4d9d1ed14e7aaa1d1828989b0272": "02bab0d4d2ee9fb2348cb3adf229db8a",
".git/objects/b6/b8806f5f9d33389d53c2868e6ea1aca7445229": "b14016efdbcda10804235f3a45562bbf",
".git/objects/b7/49bfef07473333cf1dd31e9eed89862a5d52aa": "36b4020dca303986cad10924774fb5dc",
".git/objects/b9/2a0d854da9a8f73216c4a0ef07a0f0a44e4373": "f62d1eb7f51165e2a6d2ef1921f976f3",
".git/objects/c3/3c427aa066e8cdafa9ba1982fcc7fe5c07d393": "ad845ae30b1197afc888ab1cb71926da",
".git/objects/c3/5fa1a84f793749e5b3ec569748e8bdacaba590": "0ad422336e9c35bbac2cfc5ae972cd07",
".git/objects/c4/016f7d68c0d70816a0c784867168ffa8f419e1": "fdf8b8a8484741e7a3a558ed9d22f21d",
".git/objects/ca/3bba02c77c467ef18cffe2d4c857e003ad6d5d": "316e3d817e75cf7b1fd9b0226c088a43",
".git/objects/cd/637951abb4f5abd166e8595aa7b8323dd2a852": "bf8144e5941d4e617de22001dbb0b7d8",
".git/objects/d2/af564fe0b932471b39a3c399ff344f353c8568": "7a816b16747e066397aea602096c9dbe",
".git/objects/d4/3532a2348cc9c26053ddb5802f0e5d4b8abc05": "3dad9b209346b1723bb2cc68e7e42a44",
".git/objects/d6/9c56691fbdb0b7efa65097c7cc1edac12a6d3e": "868ce37a3a78b0606713733248a2f579",
".git/objects/dd/bd77616223a7927641a4f08716e256fcbe0609": "3b4816aace314fb5a5622fcc03bfafde",
".git/objects/e3/e9ee754c75ae07cc3d19f9b8c1e656cc4946a1": "14066365125dcce5aec8eb1454f0d127",
".git/objects/e8/8fea7f6e52ac8ee10635b36de1b34307ec4314": "2a574fab52b8e12cc816d871a408b22c",
".git/objects/e9/b1a14ec8f40e7021c814a8fe8d555754a498f6": "0b6f973af0e2dd55981919edd91f2cfe",
".git/objects/eb/9b4d76e525556d5d89141648c724331630325d": "37c0954235cbe27c4d93e74fe9a578ef",
".git/objects/ed/b55d4deb8363b6afa65df71d1f9fd8c7787f22": "886ebb77561ff26a755e09883903891d",
".git/objects/ef/e26a8364453fbcad243213c5f3b1f5bf326fe1": "b4750c1e3d3d8abb959e9d0709a9425b",
".git/objects/f2/04823a42f2d890f945f70d88b8e2d921c6ae26": "6b47f314ffc35cf6a1ced3208ecc857d",
".git/objects/f4/fca17fdf7294d1c492073baac7359a6f77b642": "954b24aba8489cab4b80dc9350bf68e9",
".git/objects/f8/29d3b4fc49389ec81dec558e4f70b8af0c71db": "57d5f66e2d8e976d37136e15344eb624",
".git/objects/f9/99ddbce7387dd64f4ee18aba0af4b680d436e4": "ae2c2a559c248b660d985699eac22c18",
".git/objects/fe/3b987e61ed346808d9aa023ce3073530ad7426": "dc7db10bf25046b27091222383ede515",
".git/refs/heads/gh-pages": "9e0f925b20a2d0a34bfe2c177ebefb94",
".git/refs/remotes/origin/gh-pages": "9e0f925b20a2d0a34bfe2c177ebefb94",
"assets/AssetManifest.bin": "78acb54eb747116dfa3a5342daed2ccc",
"assets/AssetManifest.bin.json": "cd98d66d4cae618eec638d26bd49d221",
"assets/AssetManifest.json": "7a3895f8af69fe3d6bf9d84cdbf9512f",
"assets/assets/images/alakazam.png": "d9bc851b48770109ae0fbeeb56661f84",
"assets/assets/images/blastoise.png": "cd79065b8e6cd032deeede3e727239aa",
"assets/assets/images/bulbasaur.png": "ba7202bb8f8b50743809422efa6c0144",
"assets/assets/images/charizard.png": "521b2e6d546ed678dce3b565316709ae",
"assets/assets/images/dragonite.png": "a5fb5bd8f00970620e9d44ef2951e5a1",
"assets/assets/images/eevee.png": "5580e07ade60fb33a74a7c99ae59d730",
"assets/assets/images/flareon.png": "92b5450dc85d9995c77c9a85b986c5e3",
"assets/assets/images/gengar.png": "ab6fd0a6c03610d5d4ed03032933d488",
"assets/assets/images/greninja.png": "733f4536fddb29cf5efcc6958615f1ee",
"assets/assets/images/gyarados.png": "a0d4be5670282afb3ee5be779c4a6013",
"assets/assets/images/jolteon.png": "90e9e3190d949aae68e760612516bb75",
"assets/assets/images/logo.png": "86a071730385f97593b719dfcfce1806",
"assets/assets/images/lucario.png": "61cecab404a0c84ca609e3e05d321a17",
"assets/assets/images/machamp.png": "a39a16071d3394f9b7222bb2a61f1eef",
"assets/assets/images/pikachu.png": "69e9a38b0e5c777ed073be256aeccdfd",
"assets/assets/images/snorlax.png": "613c9f8a97faee899568ea43cc45c249",
"assets/assets/images/tyranitar.png": "73898069df5007be4749c67cc058c7fd",
"assets/assets/images/vaporeon.png": "09d921872d352fae4d27088457a3a3a9",
"assets/FontManifest.json": "7b2a36307916a9721811788013e65289",
"assets/fonts/MaterialIcons-Regular.otf": "df135dd4927ea286a009fffa49b20f58",
"assets/NOTICES": "5e4e05e4f77b2fa0a89607336ef22c02",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "140ccb7d34d0a55065fbd422b843add6",
"canvaskit/canvaskit.js.symbols": "58832fbed59e00d2190aa295c4d70360",
"canvaskit/canvaskit.wasm": "07b9f5853202304d3b0749d9306573cc",
"canvaskit/chromium/canvaskit.js": "5e27aae346eee469027c80af0751d53d",
"canvaskit/chromium/canvaskit.js.symbols": "193deaca1a1424049326d4a91ad1d88d",
"canvaskit/chromium/canvaskit.wasm": "24c77e750a7fa6d474198905249ff506",
"canvaskit/skwasm.js": "1ef3ea3a0fec4569e5d531da25f34095",
"canvaskit/skwasm.js.symbols": "0088242d10d7e7d6d2649d1fe1bda7c1",
"canvaskit/skwasm.wasm": "264db41426307cfc7fa44b95a7772109",
"canvaskit/skwasm_heavy.js": "413f5b2b2d9345f37de148e2544f584f",
"canvaskit/skwasm_heavy.js.symbols": "3c01ec03b5de6d62c34e17014d1decd3",
"canvaskit/skwasm_heavy.wasm": "8034ad26ba2485dab2fd49bdd786837b",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "888483df48293866f9f41d3d9274a779",
"flutter_bootstrap.js": "80d4aa56e2308676f02c9281adb11c18",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "4753ff48e4cabb051d219c6a6cb3a8e7",
"/": "4753ff48e4cabb051d219c6a6cb3a8e7",
"main.dart.js": "7202ac5111e97ee61a571fb9009a8223",
"manifest.json": "c49d62f8063cf21e526bd7ecf6c3e4fc",
"version.json": "d806b75816d666d2b6a533c0e39422ff"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
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
        // Claim client to enable caching on first launch
        self.clients.claim();
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
      // Claim client to enable caching on first launch
      self.clients.claim();
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
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
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
