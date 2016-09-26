# Socyl

[![License GPL 2][badge-license]][LICENSE]
[![Coverage Status](https://coveralls.io/repos/nlamirault/socyl/badge.png?branch=master)](https://coveralls.io/r/nlamirault/socyl?branch=master)

Master :
* [![MELPA Stable](https://stable.melpa.org/packages/socyl-badge.svg)](https://stable.melpa.org/#/socyl)
* [![Circle CI](https://circleci.com/gh/nlamirault/socyl/tree/master.svg?style=svg)](https://circleci.com/gh/nlamirault/socyl/tree/master)

Develop:
* [![Melpa Status](https://melpa.org/packages/socyl-badge.svg)](https://melpa.org/#/socyl)
* [![Circle CI](https://circleci.com/gh/nlamirault/socyl/tree/develop.svg?style=svg)](https://circleci.com/gh/nlamirault/socyl/tree/develop)

``socyl`` allows you to search using multiple search tools:
Supported backends are :

* [ag][]
* [pt][]
* [sift][]


## Installation

The recommended way to install ``socyl`` is via [MELPA][]:

    M-x package-install socyl

or [Cask][]:

	(depends-on "socyl")


## Usage

Choose your backend :

<kbd>(setq socyl-backend 'pt)</kbd>

<kbd>M-x socyl-search-regexp</kbd>

to test backends in a IELM session :

```lisp
ELISP> (let ((socyl-backend 'pt))
         (socyl-search-regexp "Emacs" "/tmp/"))
```


## Development

### Cask

``socyl`` use [Cask][] for dependencies management. Install it and
retrieve dependencies :

    $ curl -fsSkL https://raw.github.com/cask/cask/master/go | python
    $ export PATH="$HOME/.cask/bin:$PATH"
    $ cask


### Testing

* Launch unit tests from shell

    $ make clean test

* Using [overseer][] :

Keybinding           | Description
---------------------|------------------------------------------------------------
<kbd>C-c , t</kbd>   | launch unit tests from buffer
<kbd>C-c , b</kbd>   | launch unit tests
<kbd>C-c , g</kbd>   | launch unit tests with tag (backend, ...)

* Tips:

If you want to launch a single unit test, add a specify tag :

```lisp
(ert-deftest test-foobar ()
  :tags '(current)
  ```

And launch it using : <kbd>C-c , g</kbd> and specify tag : *current*


## Support / Contribute

See [here](CONTRIBUTING.md)


## Changelog

A changelog is available [here](ChangeLog.md).


## License

See [LICENSE](LICENSE).


## Contact

Nicolas Lamirault <nicolas.lamirault@gmail.com>




[badge-license]: https://img.shields.io/badge/license-GPL_2-green.svg?style=flat
[LICENSE]: https://github.com/nlamirault/ripgrep.el/blob/master/LICENSE

[GNU Emacs]: https://www.gnu.org/software/emacs/
[MELPA]: https://melpa.org/
[Cask]: http://cask.github.io/
[Issue tracker]: https://github.com/nlamirault/ripgrep.el/issues

[overseer]: https://github.com/tonini/overseer.el

[ag]: https://github.com/ggreer/the_silver_searcher
[pt]: https://github.com/monochromegane/the_platinum_searcher
[sift]: https://sift-tool.org/
[ripgrep]: https://github.com/BurntSushi/ripgrep
