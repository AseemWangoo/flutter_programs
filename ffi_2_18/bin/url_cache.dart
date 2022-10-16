import 'dart:ffi';
import '../url_cache_bindings.dart';

void main(List<String> args) {
  const dylibPath =
      '/System/Library/Frameworks/Foundation.framework/Versions/Current/Foundation';

  final lib = URLCacheLibrary(DynamicLibrary.open(dylibPath));

  final urlCache = NSURLCache.getSharedURLCache(lib);
  if (urlCache != null) {
    print('currentDiskUsage: ${urlCache.currentDiskUsage}');
    print('currentMemoryUsage: ${urlCache.currentMemoryUsage}');
    print('diskCapacity: ${urlCache.diskCapacity}');
    print('memoryCapacity: ${urlCache.memoryCapacity}');
  }
}
