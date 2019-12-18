// Copyright 2019 terrier989@gmail.com
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
/*
Some source code in this file was adopted from 'dart:html' in Dart SDK. See:
  https://github.com/dart-lang/sdk/tree/master/tools/dom

The source code adopted from 'dart:html' had the following license:

  Copyright 2012, the Dart project authors. All rights reserved.
  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are
  met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above
      copyright notice, this list of conditions and the following
      disclaimer in the documentation and/or other materials provided
      with the distribution.
    * Neither the name of Google Inc. nor the names of its
      contributors may be used to endorse or promote products derived
      from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

part of universal_html.internal;

class History {
  final List<_HistoryState> _stack = [
    _HistoryState(null, "", window.location.href),
  ];

  int _index = 0;
  dynamic _state;

  History._();

  int get length => _stack.length;

  String get scrollRestoration {
    throw UnimplementedError();
  }

  dynamic get state => _state;

  void back() {
    go(-1);
  }

  void forward() {
    go(1);
  }

  void go(int delta) {
    final newIndex = this._index + delta;
    if (newIndex < 0 || newIndex >= _stack.length) {
      // Fail silently
      return;
    }
    _setStateAndDispatchEvent(_stack[newIndex]);
    _index = newIndex;
  }

  void pushState(dynamic data, String title, String url) {
    url = _resolve(url);
    final state = _HistoryState(data, title, url);
    _stack.add(state);
    _index = _stack.length - 1;
    _setStateAndDispatchEvent(state);
  }

  void replaceState(dynamic data, String title, String url) {
    url = _resolve(url);
    final state = _HistoryState(data, title, url);
    _stack.removeLast();
    _stack.add(state);
    _setStateAndDispatchEvent(state);
  }

  void _setStateAndDispatchEvent(_HistoryState state) {
    this._state = state.data;
    window.location.replace(state.url);
    window.dispatchEvent(PopStateEvent._(state: state.data));
  }

  static String _resolve(String url) {
    var parsedUrl = Uri.parse(url);
    if (parsedUrl.isAbsolute) {
      return url;
    }
    return Uri.parse(window.location.href).resolve(url).toString();
  }
}

class Location extends Object with _UrlBase {
  final HtmlDriver _htmlDriver;

  Location._(this._htmlDriver);

  List<String> get ancestorOrigins => <String>[];

  String get href => _htmlDriver.uriString;

  set href(String value) {
    _htmlDriver.uri = Uri.parse(value);
  }

  @override
  Uri get _uri => _htmlDriver.uri;

  void assign([String url]) {
    if (url == null) {
      return;
    }
    replace(url);
  }

  void reload() {
    _htmlDriver.reload();
  }

  void replace(String url) {
    this.href = url;
  }
}

class Url extends _UrlBase {
  @override
  Uri _uri; // ignore: prefer_final_fields

  Url._(this._uri);

  static String createObjectUrl(dynamic blob_OR_source_OR_stream) {
    throw UnimplementedError();
  }

  static String createObjectUrlFromBlob(Blob blob) {
    throw UnimplementedError();
  }

  static String createObjectUrlFromSource(MediaSource source) {
    throw UnimplementedError();
  }

  static String createObjectUrlFromStream(MediaStream stream) {
    throw UnimplementedError();
  }

  static void revokeObjectUrl(String url) {}
}

class _HistoryState {
  final dynamic data;
  final String title;
  final String url;

  _HistoryState(this.data, this.title, this.url);
}

abstract class _UrlBase {
  String get hash {
    final uri = this._uri;
    if (uri.hasFragment) {
      return "#${uri.fragment}";
    }
    return "";
  }

  set hash(String value) {
    throw UnimplementedError();
  }

  String get host {
    final uri = this._uri;
    if (uri == null) return "";
    final hostname = _uri.host ?? "";
    final port = _uri.port;
    return port == null ? hostname : "${hostname}:${port}";
  }

  String get hostname => _uri?.host ?? "";

  String get origin => _uri?.origin;

  String get pathname => _uri?.path ?? "";

  set pathname(String value) {
    throw UnimplementedError();
  }

  String get port {
    final uri = this._uri;
    if (uri == null) return "";
    final port = uri.port;
    return port == 0 ? "" : port.toString();
  }

  set port(String value) {
    throw UnimplementedError();
  }

  String get protocol {
    final scheme = _uri?.scheme;
    if (scheme == null) return ":";
    return "$scheme:";
  }

  String get search => _uri?.query ?? "";

  set search(String value) {
    throw UnimplementedError();
  }

  Uri get _uri;
}
