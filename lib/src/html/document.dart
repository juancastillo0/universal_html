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

part of universal_html;

HtmlDocument get document => HtmlDriver.current.document;

/// Finds the first descendant element of this document that matches the
/// specified group of selectors.
///
/// Unless your webpage contains multiple documents, the top-level
/// [querySelector]
/// method behaves the same as this method, so you should use it instead to
/// save typing a few characters.
///
/// [selectors] should be a string using CSS selector syntax.
///
///     var element1 = document.querySelector('.className');
///     var element2 = document.querySelector('#id');
///
/// For details about CSS selector syntax, see the
/// [CSS selector specification](http://www.w3.org/TR/css3-selectors/).
T querySelector<T extends Element>(String s) => document.querySelector(s);

/// Finds all descendant elements of this document that match the specified
/// group of selectors.
///
/// Unless your webpage contains multiple documents, the top-level
/// [querySelectorAll]
/// method behaves the same as this method, so you should use it instead to
/// save typing a few characters.
///
/// [selectors] should be a string using CSS selector syntax.
///
///     var items = document.querySelectorAll('.itemClassName');
///
/// For details about CSS selector syntax, see the
/// [CSS selector specification](http://www.w3.org/TR/css3-selectors/).
ElementList<T> querySelectorAll<T extends Element>(String s) =>
    document.querySelectorAll<T>(s);

abstract class Document extends Node
    with _ElementOrDocument, DocumentOrShadowRoot, _DocumentOrFragment {
  static const EventStreamProvider<Event> pointerLockChangeEvent =
      EventStreamProvider<Event>('pointerlockchange');

  static const EventStreamProvider<Event> pointerLockErrorEvent =
      EventStreamProvider<Event>('pointerlockerror');

  /// Static factory designed to expose `readystatechange` events to event
  /// handlers that are not necessarily instances of [Document].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<Event> readyStateChangeEvent =
      EventStreamProvider<Event>('readystatechange');

  /// Static factory designed to expose `securitypolicyviolation` events to event
  /// handlers that are not necessarily instances of [Document].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<SecurityPolicyViolationEvent>
      securityPolicyViolationEvent =
      EventStreamProvider<SecurityPolicyViolationEvent>(
          'securitypolicyviolation');

  /// Static factory designed to expose `selectionchange` events to event
  /// handlers that are not necessarily instances of [Document].
  ///
  /// See [EventStreamProvider] for usage information.
  static const EventStreamProvider<Event> selectionChangeEvent =
      EventStreamProvider<Event>('selectionchange');

  final HtmlDriver _htmlDriver;
  final String contentType;

  factory Document() {
    return XmlDocument.internal(HtmlDriver.current, contentType: "text/html");
  }

  Document._(this._htmlDriver, this.contentType) : super._document();

  /// Outside the browser, returns null.
  Element get activeElement => null;

  @override
  String get baseUri {
    return window.location.href;
  }

  Element get documentElement {
    var node = firstChild;
    while (node != null) {
      if (node is Element) {
        return node;
      }
      node = node.nextNode;
    }
    return null;
  }

  DomImplementation get implementation => DomImplementation._(_htmlDriver);

  @override
  int get nodeType => Node.DOCUMENT_NODE;

  /// Stream of `abort` events handled by this [Document].
  Stream<Event> get onAbort => Element.abortEvent.forTarget(this);

  /// Stream of `beforecopy` events handled by this [Document].
  Stream<Event> get onBeforeCopy => Element.beforeCopyEvent.forTarget(this);

  /// Stream of `beforecut` events handled by this [Document].
  Stream<Event> get onBeforeCut => Element.beforeCutEvent.forTarget(this);

  /// Stream of `beforepaste` events handled by this [Document].
  Stream<Event> get onBeforePaste => Element.beforePasteEvent.forTarget(this);

  /// Stream of `blur` events handled by this [Document].
  Stream<Event> get onBlur => Element.blurEvent.forTarget(this);

  Stream<Event> get onCanPlay => Element.canPlayEvent.forTarget(this);

  Stream<Event> get onCanPlayThrough =>
      Element.canPlayThroughEvent.forTarget(this);

  /// Stream of `change` events handled by this [Document].
  Stream<Event> get onChange => Element.changeEvent.forTarget(this);

  /// Stream of `click` events handled by this [Document].
  Stream<MouseEvent> get onClick => Element.clickEvent.forTarget(this);

  /// Stream of `contextmenu` events handled by this [Document].
  Stream<MouseEvent> get onContextMenu =>
      Element.contextMenuEvent.forTarget(this);

  /// Stream of `copy` events handled by this [Document].
  Stream<ClipboardEvent> get onCopy => Element.copyEvent.forTarget(this);

  /// Stream of `cut` events handled by this [Document].
  Stream<ClipboardEvent> get onCut => Element.cutEvent.forTarget(this);

  /// Stream of `doubleclick` events handled by this [Document].
  @DomName('Document.ondblclick')
  Stream<Event> get onDoubleClick => Element.doubleClickEvent.forTarget(this);

  /// Stream of `drag` events handled by this [Document].
  Stream<MouseEvent> get onDrag => Element.dragEvent.forTarget(this);

  /// Stream of `dragend` events handled by this [Document].
  Stream<MouseEvent> get onDragEnd => Element.dragEndEvent.forTarget(this);

  /// Stream of `dragenter` events handled by this [Document].
  Stream<MouseEvent> get onDragEnter => Element.dragEnterEvent.forTarget(this);

  /// Stream of `dragleave` events handled by this [Document].
  Stream<MouseEvent> get onDragLeave => Element.dragLeaveEvent.forTarget(this);

  /// Stream of `dragover` events handled by this [Document].
  Stream<MouseEvent> get onDragOver => Element.dragOverEvent.forTarget(this);

  /// Stream of `dragstart` events handled by this [Document].
  Stream<MouseEvent> get onDragStart => Element.dragStartEvent.forTarget(this);

  /// Stream of `drop` events handled by this [Document].
  Stream<MouseEvent> get onDrop => Element.dropEvent.forTarget(this);

  Stream<Event> get onDurationChange =>
      Element.durationChangeEvent.forTarget(this);

  Stream<Event> get onEmptied => Element.emptiedEvent.forTarget(this);

  Stream<Event> get onEnded => Element.endedEvent.forTarget(this);

  /// Stream of `error` events handled by this [Document].
  Stream<Event> get onError => Element.errorEvent.forTarget(this);

  /// Stream of `focus` events handled by this [Document].
  Stream<Event> get onFocus => Element.focusEvent.forTarget(this);

  /// Stream of `fullscreenchange` events handled by this [Document].
  Stream<Event> get onFullscreenChange =>
      Element.fullscreenChangeEvent.forTarget(this);

  /// Stream of `fullscreenerror` events handled by this [Document].
  Stream<Event> get onFullscreenError =>
      Element.fullscreenErrorEvent.forTarget(this);

  /// Stream of `input` events handled by this [Document].
  Stream<Event> get onInput => Element.inputEvent.forTarget(this);

  /// Stream of `invalid` events handled by this [Document].
  Stream<Event> get onInvalid => Element.invalidEvent.forTarget(this);

  /// Stream of `keydown` events handled by this [Document].
  Stream<KeyboardEvent> get onKeyDown => Element.keyDownEvent.forTarget(this);

  /// Stream of `keypress` events handled by this [Document].
  Stream<KeyboardEvent> get onKeyPress => Element.keyPressEvent.forTarget(this);

  /// Stream of `keyup` events handled by this [Document].
  Stream<KeyboardEvent> get onKeyUp => Element.keyUpEvent.forTarget(this);

  /// Stream of `load` events handled by this [Document].
  Stream<Event> get onLoad => Element.loadEvent.forTarget(this);

  Stream<Event> get onLoadedData => Element.loadedDataEvent.forTarget(this);

  Stream<Event> get onLoadedMetadata =>
      Element.loadedMetadataEvent.forTarget(this);

  /// Stream of `mousedown` events handled by this [Document].
  Stream<MouseEvent> get onMouseDown => Element.mouseDownEvent.forTarget(this);

  /// Stream of `mouseenter` events handled by this [Document].
  Stream<MouseEvent> get onMouseEnter =>
      Element.mouseEnterEvent.forTarget(this);

  /// Stream of `mouseleave` events handled by this [Document].
  Stream<MouseEvent> get onMouseLeave =>
      Element.mouseLeaveEvent.forTarget(this);

  /// Stream of `mousemove` events handled by this [Document].
  Stream<MouseEvent> get onMouseMove => Element.mouseMoveEvent.forTarget(this);

  /// Stream of `mouseout` events handled by this [Document].
  Stream<MouseEvent> get onMouseOut => Element.mouseOutEvent.forTarget(this);

  /// Stream of `mouseover` events handled by this [Document].
  Stream<MouseEvent> get onMouseOver => Element.mouseOverEvent.forTarget(this);

  /// Stream of `mouseup` events handled by this [Document].
  Stream<MouseEvent> get onMouseUp => Element.mouseUpEvent.forTarget(this);

  /// Stream of `mousewheel` events handled by this [Document].
  Stream<WheelEvent> get onMouseWheel =>
      Element.mouseWheelEvent.forTarget(this);

  /// Stream of `paste` events handled by this [Document].
  Stream<ClipboardEvent> get onPaste => Element.pasteEvent.forTarget(this);

  Stream<Event> get onPause => Element.pauseEvent.forTarget(this);

  Stream<Event> get onPlay => Element.playEvent.forTarget(this);

  Stream<Event> get onPlaying => Element.playingEvent.forTarget(this);

  Stream<Event> get onPointerLockChange =>
      pointerLockChangeEvent.forTarget(this);

  Stream<Event> get onPointerLockError => pointerLockErrorEvent.forTarget(this);

  Stream<Event> get onRateChange => Element.rateChangeEvent.forTarget(this);

  /// Stream of `readystatechange` events handled by this [Document].
  Stream<Event> get onReadyStateChange => readyStateChangeEvent.forTarget(this);

  /// Stream of `reset` events handled by this [Document].
  Stream<Event> get onReset => Element.resetEvent.forTarget(this);

  Stream<Event> get onResize => Element.resizeEvent.forTarget(this);

  /// Stream of `scroll` events handled by this [Document].
  Stream<Event> get onScroll => Element.scrollEvent.forTarget(this);

  /// Stream of `search` events handled by this [Document].
  Stream<Event> get onSearch => Element.searchEvent.forTarget(this);

  /// Stream of `securitypolicyviolation` events handled by this [Document].
  Stream<SecurityPolicyViolationEvent> get onSecurityPolicyViolation =>
      securityPolicyViolationEvent.forTarget(this);

  Stream<Event> get onSeeked => Element.seekedEvent.forTarget(this);

  Stream<Event> get onSeeking => Element.seekingEvent.forTarget(this);

  /// Stream of `select` events handled by this [Document].
  Stream<Event> get onSelect => Element.selectEvent.forTarget(this);

  /// Stream of `selectionchange` events handled by this [Document].
  Stream<Event> get onSelectionChange => selectionChangeEvent.forTarget(this);

  /// Stream of `selectstart` events handled by this [Document].
  Stream<Event> get onSelectStart => Element.selectStartEvent.forTarget(this);

  Stream<Event> get onStalled => Element.stalledEvent.forTarget(this);

  /// Stream of `submit` events handled by this [Document].
  Stream<Event> get onSubmit => Element.submitEvent.forTarget(this);

  Stream<Event> get onSuspend => Element.suspendEvent.forTarget(this);

  Stream<Event> get onTimeUpdate => Element.timeUpdateEvent.forTarget(this);

  /// Stream of `touchcancel` events handled by this [Document].
  Stream<TouchEvent> get onTouchCancel =>
      Element.touchCancelEvent.forTarget(this);

  /// Stream of `touchend` events handled by this [Document].
  Stream<TouchEvent> get onTouchEnd => Element.touchEndEvent.forTarget(this);

  /// Stream of `touchmove` events handled by this [Document].
  Stream<TouchEvent> get onTouchMove => Element.touchMoveEvent.forTarget(this);

  /// Stream of `touchstart` events handled by this [Document].
  Stream<TouchEvent> get onTouchStart =>
      Element.touchStartEvent.forTarget(this);

  Stream<Event> get onVolumeChange => Element.volumeChangeEvent.forTarget(this);

  Stream<Event> get onWaiting => Element.waitingEvent.forTarget(this);

  Node adoptNode(Node node) {
    final clone = node.internalCloneWithOwnerDocument(this, true);
    clone._parent = null;
    return clone;
  }

  DocumentFragment createDocumentFragment() {
    return DocumentFragment.internal(this);
  }

  Element createElement(String tagName, [String typeExtension]) {
    return Element.internalTag(this, tagName, typeExtension);
  }

  Element createElementNS(String namespaceUri, String qualifiedName,
      [String typeExtension]) {
    return Element.internalTagNS(
        this, namespaceUri, qualifiedName, typeExtension);
  }

  List<Node> getElementsByClassName(String classNames) {
    final result = <Node>[];
    final classNameList = classNames.split(" ");
    this._forEachTreeElement((element) {
      for (var className in classNameList) {
        if (!element.classes.contains(className)) {
          return;
        }
      }
      result.add(element);
    });
    return result;
  }

  List<Node> getElementsByName(String elementName) {
    // Only works in XHTML documents
    if (document is HtmlDocument) {
      return const <Node>[];
    }
    elementName = elementName.toLowerCase();
    final result = <Node>[];
    this._forEachTreeElement((element) {
      if (element._lowerCaseTagName == elementName) {
        result.add(element);
      }
    });
    return result;
  }

  List<Node> getElementsByTagName(String tagName) {
    tagName = tagName.toLowerCase();
    final result = <Node>[];
    this._forEachTreeElement((element) {
      if (element._lowerCaseTagName == tagName) {
        result.add(element);
      }
    });
    return result;
  }

  @override
  void insertBefore(Node node, Node before) {
    if (node is Element) {
      if (this._firstElementChild != null) {
        throw DomException._failedToExecute(
          DomException.HIERARCHY_REQUEST,
          "Node",
          "appendChild",
          "Only one element on document allowed.",
        );
      }
    } else if (node is DocumentType) {
      // OK
    } else if (node is Comment) {
      // OK
    } else if (node is Text) {
      // Check that the text is whitespace
      final value = node.text.replaceAll("\n", "").trim();
      if (value.isNotEmpty) {
        throw DomException._mayNotBeInsertedInside(
          "Document",
          "insertBefore",
          node,
          this,
        );
      }
      // Ignore the text
      return;
    } else {
      throw DomException._mayNotBeInsertedInside(
        "Document",
        "insertBefore",
        node,
        this,
      );
    }

    // Insert
    super.insertBefore(node, before);
  }

  @override
  void remove() {
    throw UnsupportedError("Can't be removed");
  }
}

abstract class DocumentOrShadowRoot {
  Element get activeElement => null;

  Element get fullscreenElement => null;

  Element get pointerLockElement => null;
}

class DomImplementation {
  final HtmlDriver _htmlDriver;

  DomImplementation._(this._htmlDriver);

  XmlDocument createDocument(
      String namespaceURI, String qualifiedName, DocumentType doctype) {
    final result = XmlDocument.internal(_htmlDriver, contentType: "text/xml");
    if (doctype != null) {
      result.append(doctype.internalCloneWithOwnerDocument(result, true));
    }
    final element = result.createElement(qualifiedName);
    if (namespaceURI != null) {
      element.setAttribute("xmlns", namespaceURI);
    }
    return result;
  }

  DocumentType createDocumentType(
      String qualifiedName, String publicId, String systemId) {
    return DocumentType.internal(null, null);
  }

  HtmlDocument createHtmlDocument([String title]) {
    return HtmlDocument.internal(
      _htmlDriver,
      contentType: "text/html",
      filled: false,
    );
  }
}

class HtmlDocument extends Document {
  /// IMPORTANT: Not part 'dart:html'.
  ///
  /// If [filled] is true, returns document:
  ///
  ///     <doctype html>
  ///     <html>
  ///     <head></head>
  ///     <body></body>
  ///     </html>
  HtmlDocument.internal(HtmlDriver driver,
      {@required String contentType, @required bool filled})
      : super._(driver, contentType) {
    if (filled) {
      final docType = DocumentType.internal(this, "html");
      append(docType);
      final htmlElement = HtmlHtmlElement._(this);
      append(htmlElement);
      htmlElement.append(HeadElement._(this));
      htmlElement.append(BodyElement._(this));
    }
  }

  @override
  String get baseUri {
    if (head != null) {
      for (var child in head.children) {
        if (child is BaseElement) {
          return child.href;
        }
      }
    }
    return super.baseUri;
  }

  BodyElement get body {
    Element element = this._html?._firstElementChild;
    while (element != null) {
      if (element is BodyElement) {
        return element;
      }
      element = element.nextElementSibling;
    }
    return null;
  }

  set body(BodyElement newValue) {
    final existing = this.head;
    if (existing == null) {
      _html?.append(newValue);
    } else {
      existing.replaceWith(newValue);
    }
    assert(identical(this.body, newValue));
  }

  HeadElement get head {
    Element element = this._html?._firstElementChild;
    while (element != null) {
      if (element is HeadElement) {
        return element;
      }
      element = element.nextElementSibling;
    }
    return null;
  }

  set head(HeadElement newValue) {
    final existing = this.head;
    if (existing == null) {
      _html?.append(newValue);
    } else {
      existing.replaceWith(newValue);
    }
    assert(identical(this.head, newValue));
  }

  List<StyleSheet> get styleSheets {
    final list = <StyleSheet>[];
    _forEachTreeElement((element) {
      if (element is StyleElement) {
        list.add(element.sheet);
      }
    });
    return list;
  }

  HtmlHtmlElement get _html {
    Element element = this._firstElementChild;
    while (element != null) {
      if (element is HtmlHtmlElement) {
        return element;
      }
      element = element.nextElementSibling;
    }
    return null;
  }

  @override
  Node internalCloneWithOwnerDocument(Document ownerDocument, bool deep) {
    final clone = HtmlDocument.internal(
      _htmlDriver,
      contentType: contentType,
      filled: false,
    );
    if (deep != false) {
      Node._cloneChildrenFrom(clone, clone, this);
    }
    return clone;
  }
}

abstract class _DocumentOrFragment implements Node, _ElementOrDocument {
  Element getElementById(String id) {
    Element result;
    _forEachTreeElement((element) {
      if (element.id == id) {
        result = element;
      }
    });
    return result;
  }

  @override
  void remove() {
    throw UnsupportedError("Can't be removed");
  }
}
