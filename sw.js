const CACHE='suivi-concours-v079-20260901-force';
const FALLBACK='./index.html?v=079';

self.addEventListener('install',event=>{
  self.skipWaiting();
  event.waitUntil(
    caches.open(CACHE).then(cache=>cache.add(new Request(FALLBACK,{cache:'reload'})))
  );
});

self.addEventListener('activate',event=>{
  event.waitUntil(
    caches.keys()
      .then(keys=>Promise.all(keys.filter(k=>k!==CACHE).map(k=>caches.delete(k))))
      .then(()=>self.clients.claim())
  );
});

self.addEventListener('fetch',event=>{
  const req=event.request;
  if(req.mode==='navigate'){
    event.respondWith(
      fetch(new Request(req,{cache:'no-store'}))
        .then(response=>{
          const copy=response.clone();
          caches.open(CACHE).then(cache=>cache.put(FALLBACK,copy));
          return response;
        })
        .catch(()=>caches.match(FALLBACK))
    );
    return;
  }

  event.respondWith(
    fetch(new Request(req,{cache:'no-cache'}))
      .then(response=>{
        if(req.method==='GET'){
          const copy=response.clone();
          caches.open(CACHE).then(cache=>cache.put(req,copy));
        }
        return response;
      })
      .catch(()=>caches.match(req))
  );
});
