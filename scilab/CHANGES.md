Welcome to Scilab 2025.1.0
==========================

This file details the changes between Scilab 2025.1.0 (this version), and the previous 2024.1.0 stable release (including information from 2025.0.0).
For changelogs of earlier releases, please see [Scilab 2025.0.0][1].

Summary:

- New features
- Obsolete functions & features
- Removed functions & features
- Compilation & Packaging
- Known incompatibilities
- Fixed issues

Please report anything we could have missed, on [Discourse][2] or on [GitLab][3].

[1]: https://help.scilab.org/docs/2025.0.0/en_US/CHANGES.html
[2]: https://scilab.discourse.group/
[3]: https://gitlab.com/scilab/scilab/-/issues

New features
------------

For a high-level description of this release's main new features, please consult the "What's new" page of embedded documentation available by simply typing `doc` in the Scilab console.

### Scilab 2025.1.0

#### New functions

- `addvars`: Add variables to table or timeseries.
- `combinations`: Create a table containing all elements combinations.
- `join`: Combine two tables or timeseries.
- `removevars`: Remove variables from table or timeseries.
- `diffxy`: Derivative of y with respect to x.
- `hadamard`: Hadamard matrix.
- `hankel`: Hankel matrix.
- `pascal`: Pascal matrix.
- `rosser`: Rosser matrix.
- `wilkinson`: Wilkinson matrix.
- `day`: Extract day from datetime.
- `month`: Extract month from datetime.
- `cart2pol`: Convert cartesian coordinates to polar/cylindrical.
- `pol2cart`: Convert polar/cylindrical coordinates to cartesian.
- `cylinder`: Compute cylinder coordinates.
- `peaks`: Compute values of a function with lots of local maxima and minima.
- `sphere`: Compute sphere coordinates.
- `rmfield`: Remove fields from a struct.
- `tbx_package`: Package a toolbox source tree with binaries into a single file.

#### Features improvements

- New helpers for `arguments`: `mustBeScalar`, `mustBeScalarOrEmpty`, `mustBeEqualDimsOrEmpty`, `mustBeRow`, `mustBeColumn`.
- `mustBeA` helper can now manage "empty" type (for empty matrix cases).
- `toJSON()` and `fromJSON()` are now based on RapidJSON for efficiency and can manage `%Nan`, `-%Inf` and `%Inf` values.
- Option names are no more case-sensitive in `pca()`, `datetime()`, ...
- `polyfit()` now manages weights for `y` data.
- `host()` can now return both standard output and standard error.

#### Graphics & GUI

- New "browser" style `uicontrol` based on JCEF (See [dedicated post on Discourse](https://scilab.discourse.group/t/scilab-2025-1-0-preview-browser-uicontrol/)).
- New discrete/qualitative colormaps: `flag`, `prism`, `Accent`, `Dark2`, `Paired`, `Pastel1`, `Pastel2`, `Set1`, `Set2` and `Set3`.
- New `turbo` colormap: varying from blue, lightblue, green, yellow, orange then red (quite similar to `jet` but perceptually uniform).

#### Performances

- `time` module have been updated to use the `arguments` block and enhance its performances.
- `writetable` and `writetimeseries` have been optimized.
- `addcolor` performances have been improved mainly for huge colormaps.

#### Xcos

- [SSP](https://ssp-standard.org/) (System Structure and Parametrization) format support preview: Xcos can now load & save SSP files (hence providing better interoperability with other simulation tools).

### Scilab 2025.0.0

#### New functions

- `frank`: Computes Frank matrix.
- `getdeprecated`: Gets names of deprecated functions and replacement function names.
- `hilbm`: Computes Hilbert matrix.
- `invhilb`: Computes inverse of Hilbert matrix.
- `kmeans`: K-means clustering function.
- `magic`: Computes magic square matrix.
- `polyfit`: Fits a curve with a polynomial.
- `polyval`: Evaluates a polynomial for some given values.
- `vander`: Computes Vandermonde matrix.

#### Features improvements

- `-e` and `-f` command-line options can now be used simultaneously  (and are run in the order they are given to Scilab).
- `x_dialog` and `x_mdialog` can now be used to enter hidden entries such as passwords.

#### Language changes

- Lambda functions are now available in Scilab using a dedicated syntax `#(x) -> (x+1)`
- New simplified syntax to declare complex numbers: `1i` and `1j` (equivalent to `1*%i`).

#### Web tools

- `timeout` optional parameter has been added to `http_*` functions.
- `http_upload` can be used to upload a remote file with a different name as local one.

#### Graphics & GUI

- New property `"TooltipString"` added for `uimenu` handles.
- New properties `"cdata_bounds"` & `"color_range"` added for `Fac3d` handles.
- `"anti_aliasing"` property value is now `"8x"` by default for graphic figures (Anti-aliasing was deactivated by default in previous versions).
- `"fractional_font"` property value is now `"on"` by default for text handles (is was `"off"` by default in previous versions).
- Graphics functions now return the handles they created: `h = plot()`, `h = surf()`, ... This feature can be used to replace `h = gce()` in some cases.

A new way to manage rendering (raw text, LaTeX, MathML) of strings in graphics figures with:

- `"interpreter"` property added for `Text`, `Datatip`, `Label` and `Legend` handles,
- `"tics_interpreters"` property added for `Axis` handles,
- `"interpreters"` property added for `x_ticks`, `y_ticks` and `z_ticks` for `Axes` handles.

Some GUI (File Browser, Help Browser, ...) have been improved.

#### Performances

- Some Scilab modules (`CACSD`, `Linear Algebra`, ...) have been updated to use the `arguments` block and enhance their performances.
- Threads management in Scilab kernel has been completely rewritten.

Obsolete functions or features
------------------------------

### Scilab 2025.1.0

All these functions and features will be removed in Scilab 2026.0.0 (October 2025):

- `"figure_style"` property (useless since Scilab 5.0 when old graphics renderer was unplugged). 
- Using a `"Compound"` or a `"Compound"` array as first argument in `legend` function (this feature was not documented and should not have been used).

### Scilab 2025.0.0

All these functions and features will be removed in Scilab 2026.0.0 (October 2025):

- `impl()`: Please use `dae()` instead.
- `princomp()`: Please use `pca()` instead.
- `testmatrix()`: Please use `magic()`, `invhilb()` or `frank()` instead.
- `captions()`: Please use `legend()` instead.
- `help()`: Please use `doc()` instead.

Removed Functions
-----------------

The following functions have been removed:

- `getURL`, obsolete since 2023.1.0, replaced by `http_get`.
- `sound`, obsolete since 2023.1.0, replaced by `playsnd`.
- `splitURL`, obsolete since 2023.1.0, replaced by `url_split`.

Compilation
-----------

If you are familiar with building Scilab from sources, the following dependencies have been updated.

### Scilab 2025.1.0

- Required version of CURL updated to 8.10.1.
- Required version of MATIO updated to 1.5.28.
- RapidJSON 1.1.0 (or more recent) is now required.
- JCEF 127.3.1 (or more recent) is now required.
- GSON 2.10.1 (or more recent) is now required.

### Scilab 2025.0.0

- Build with HDF5 1.14.4 is now supported (with support for older versions).
- Build with libXML2 2.12.7 is now supported (with support for older versions).
- Required version of MATIO updated to 1.5.27.
- Required version of OpenBLAS updated to 0.3.28 (Linux/macOS).
- All Java dependencies of Scilab have been updated to the latest version (Java 17).

Known incompatibilities
-----------------------

### Scilab 2025.1.0

- Inline help (used by Scilab extension for Visual Studio Code) build is now disabled for toolboxes as it can produce side effects on global extension behavior. If you want to re-enable it, call `xmltoinline` in the `builder.sce` file and call `loadToolboxInlineHelp` in your toolbox `.start` file. Use these undocumented functions at your own risk.

### Scilab 2025.0.0

- `lyap` function no longer accepts non-square matrices as input.
- `pca`: the order of the first three output arguments has been modified. The old `[lambda, comprinc, scores] = pca(x)` syntax has been replaced by `[comprinc, scores, lambda] = pca(x)`. See the history part of [pca documentation](https://help.scilab.org/pca) for more information.
- `show_pca(lambda, facpr, N)`: Following the `pca` function improvements, `lambda` is now a p-by-1 vector. The ratio of the corresponding eigenvalue over the sum of eigenvalues now is computed in the `show_pca` function.
- `isvector` function and `mustBeVector` helper now return `%T` for scalars (instead of `%F` in previous versions) to be coherent with `isrow` and `iscolumn`.
- Undocumented syntax `legend(h1,h2,h3,....,strings)` is no more supported.
- When a "Legend" entity is created, its `"links"` property is now a vector with the same order as the legend strings.
- When setting the `x_ticks`, `y_ticks` and `z_ticks`, the new `"interpreters"` property must be managed.
- `fec` no more creates a `Compound` object.
- `h = plot(x1, y1, x2, y2)` now returns handles in `h` as in arguments i.e. `[h1, h2]`.

Packaging & Supported Operating Systems
---------------------------------------

### Scilab 2025.1.0

- To run or compile Scilab, you might need:
  - Windows (amd64):
    - Windows 11 (Desktop)
    - Windows 10 (Desktop)
    - Windows 8 (Desktop)
  - macOS:
    - Intel-based or M1-based Mac running macOS 11+ (compile and run)
  - Linux (amd64):
    - debian: 13
    - ubuntu: 22.04, 24.04, 25.04
    - fedora: 42

### Scilab 2025.0.0

- 32-bit platforms are not supported (no binary versions released).

- Native macOS M1/arm64 build is provided (at least 2 x faster than Intel build using Rosetta emulation).

- Scilab embedded JVM is Java 17 without a memory usage limit. Java heap size limit can still be set in Preferences (General / Java Heap Memory).

- To run or compile Scilab, you might need:
  - Windows (amd64):
    - Windows 11 (Desktop)
    - Windows 10 (Desktop)
    - Windows 8 (Desktop)
  - macOS:
    - Intel-based Mac running macOS 10.13+ (run) and 11+ (compile)
    - M1-based Mac running macOS 11+ (run, compile). 
  - Linux (amd64):
    - debian:11, 12
    - ubuntu:20.04, 22.04, 24.04
    - fedora:40, 41

Issue Fixes
-----------

### Scilab 2025.1.0

- [#6246](https://gitlab.com/scilab/scilab/-/issues/6246): `rmfield()` function was missing.
- [#9093](https://gitlab.com/scilab/scilab/-/issues/9093): `addcolor(colors)` was very slow when `length(colors)` was big.
- [#11983](https://gitlab.com/scilab/scilab/-/issues/11983): `getAllocatedSingleString()` produced wrong error messages.
- [#14340](https://gitlab.com/scilab/scilab/-/issues/14340): `tbx_package()` has been added to Scilab to make the creation on an ATOMS binary package easier.
- [#15252](https://gitlab.com/scilab/scilab/-/issues/15252): `getURL()` did not work with accentuated characters.
- [#15410](https://gitlab.com/scilab/scilab/-/issues/15410): Saving a graphic handle that was no longer valid crashed Scilab.
- [#15836](https://gitlab.com/scilab/scilab/-/issues/15836): The product `*` was not reliable for `int64` and `uint64` integers greater than `2^52`.
- [#17250](https://gitlab.com/scilab/scilab/-/issues/17250): `uimport()` GUI had some glitches under macOS.
- [#17261](https://gitlab.com/scilab/scilab/-/issues/17261): Some UIControls such as `"text"` and `"editbox"` did now support scroll by mouse wheel.
- [#17271](https://gitlab.com/scilab/scilab/-/issues/17271): `modelicac.exe`, `modelicat.exe` and `XML2modelica.exe`were 32-bits binaries, hence producing issues when trying to run any Modelica exemple from a fresh Windows installation.
- [#17318](https://gitlab.com/scilab/scilab/-/issues/17318): `atomsInstall` did not work with a URL as input argument.
- [#17320](https://gitlab.com/scilab/scilab/-/issues/17320): `vander()` documentation contained wrong formulae.
- [#17328](https://gitlab.com/scilab/scilab/-/issues/17328): `datetime("2024-10-29T07:45:59.898Z", "InputFormat","yyyy-MM-ddTHH:mm:ss.SSSZ","OutputFormat","yyyy-MM-dd HH:mm:ss.SSS")` returned an error.
- [#17329](https://gitlab.com/scilab/scilab/-/issues/17329): A space in path prevented navigation in Filebrowser.
- [#17332](https://gitlab.com/scilab/scilab/-/issues/17332): Xcos failed to save a `*.zcos` or `*.xcos` file if the file name was not explicitly added to the desired filename.
- [#17333](https://gitlab.com/scilab/scilab/-/issues/17333): Building a toolbox from Scilab startup script led to an infinite loop.
- [#17335](https://gitlab.com/scilab/scilab/-/issues/17335): Examples in `profile()` documentation more worked.
- [#17336](https://gitlab.com/scilab/scilab/-/issues/17336): None of the examples given in the ATOMS documentation worked.
- [#17338](https://gitlab.com/scilab/scilab/-/issues/17338): `detectImportOptions()` sometimes detetced wrong types of data.
- [#17339](https://gitlab.com/scilab/scilab/-/issues/17339): Insertion in a `table` could fail with an error.
- [#17340](https://gitlab.com/scilab/scilab/-/issues/17340): Catenation of tables containing different types did not trigger an error.
- [#17341](https://gitlab.com/scilab/scilab/-/issues/17341): Playing with profile could make Scilab crash.
- [#17343](https://gitlab.com/scilab/scilab/-/issues/17343): Loading a toolbox twice produces a strange error on `loadToolboxInlineHelp()` (See **Known incompatibilities**).
- [#17344](https://gitlab.com/scilab/scilab/-/issues/17344): `x_mdialog()` no more worked with boolean matrices.
- [#17345](https://gitlab.com/scilab/scilab/-/issues/17345): Modelica block in Xcos rotated after double click.
- [#17346](https://gitlab.com/scilab/scilab/-/issues/17346): When an axes had a `frame` as parent, anti-aliasing was not activated as in parent figure.
- [#17353](https://gitlab.com/scilab/scilab/-/issues/17353): Performance issue between version 2024.1.0 and version 2025.0.0 has been fixed.
- [#17354](https://gitlab.com/scilab/scilab/-/issues/17354): `barh()` produced a wrong display.
- [#17355](https://gitlab.com/scilab/scilab/-/issues/17355): `bar()` function wrongly returned a `"Compound"`(while `barh()` returned a vector of `"Polylines"`).
- [#17356](https://gitlab.com/scilab/scilab/-/issues/17356): `getfield()` crashed with a `struct` as input argument.
- [#17358](https://gitlab.com/scilab/scilab/-/issues/17358): `table()` display failed with unlimited `0` horizontal paging control.
- [#17360](https://gitlab.com/scilab/scilab/-/issues/17360): `CDATA` block in an XML `.content` field was escaped and not accessible in Scilab.
- [#17362](https://gitlab.com/scilab/scilab/-/issues/17362): Labels defined in a SUPER_f block were badly saved/restored.
- [#17364](https://gitlab.com/scilab/scilab/-/issues/17364): `[_, tz] = clock()` did not work on some GMT.
- [#17366](https://gitlab.com/scilab/scilab/-/issues/17366): `fsolve()` and `optim()` documentation needed some improvements.
- [#17368](https://gitlab.com/scilab/scilab/-/issues/17368): `bloc2ss()` failed to check input arguments type.
- [#17380](https://gitlab.com/scilab/scilab/-/issues/17380): `fminsearch()` could not be called with an anonymous function as cost function.
- [#17381](https://gitlab.com/scilab/scilab/-/issues/17381): `sci2exp()` made Scilab crash when called with an anonymous function as input.
- [#17382](https://gitlab.com/scilab/scilab/-/issues/17382): `subplot()` did not return the created/selected axes.
- [#17383](https://gitlab.com/scilab/scilab/-/issues/17383): `fromJSON("{inf:41}")` made Scilab crash.
- [#17384](https://gitlab.com/scilab/scilab/-/issues/17384): `msscanf()` made Scilab crash in some particular cases.
- [#17389](https://gitlab.com/scilab/scilab/-/issues/17389): `datetime()` failed when `"InputFormat"` specified milliseconds and when seconds value was `59`.
- [#17398](https://gitlab.com/scilab/scilab/-/issues/17398): Displaying an uninitialized `tlist` produced an error.
- [#17399](https://gitlab.com/scilab/scilab/-/issues/17399): Completion on handle properties or struct/tlist fieldnames wass case sensitive since Scilab 2025.0.0 (it was not the case before).
- [#17403](https://gitlab.com/scilab/scilab/-/issues/17403): Preferences no more loaded once a toolbox with preferences settings was uninstalled.
- [#17404](https://gitlab.com/scilab/scilab/-/issues/17404): `uint64` multiplication gaves wrong results.
- [#17406](https://gitlab.com/scilab/scilab/-/issues/17406): In Xcos, loading data in `"LOOKUP_f"` and `"Curve_f"` blocks no more worked.
- [#17411](https://gitlab.com/scilab/scilab/-/issues/17411): `test_run()` no more worked for ATOMS modules.
- [#17412](https://gitlab.com/scilab/scilab/-/issues/17412): `legend(axe_handle, ...)` no more worked if `axe_handle` was not current axes (`gca()`).
- [#17416](https://gitlab.com/scilab/scilab/-/issues/17416): Scilab 2025.0.0 did not start under macOS version 15.4. 
- [#17417](https://gitlab.com/scilab/scilab/-/issues/17417): `file_mask` did not work correctly `uigetfile()`. 
- [#17418](https://gitlab.com/scilab/scilab/-/issues/17418): There was a redundant extension in default Scinotes file name under macOS.
- [#17419](https://gitlab.com/scilab/scilab/-/issues/17419): Information about ZIP files management under Windows in `uigetfile()` documentation was obsolete.
- [#17425](https://gitlab.com/scilab/scilab/-/issues/17425): `Matplot1()` was broken for RGB images.
- [#17429](https://gitlab.com/scilab/scilab/-/issues/17429): Colors of multiple graphics in `bode()` plots were reversed w.r.t. colors shown in the legend.
- [#17431](https://gitlab.com/scilab/scilab/-/issues/17431): The last example on the `stackedplot()` documentation page was wrong.

### Scilab 2025.0.0

- [#9630](https://gitlab.com/scilab/scilab/-/issues/9630): The toolbar of the documentation browser did not behave as other toolbars.
- [#13121](https://gitlab.com/scilab/scilab/-/issues/13121): Solving ODEs could make Scilab crash under macOS.
- [#13764](https://gitlab.com/scilab/scilab/-/issues/13764): `TooltipString` property was missing for `uimenu` handles.
- [#14265](https://gitlab.com/scilab/scilab/-/issues/14265): `gcf().resize = "off"` (and other similar recursive settings) displayed a useless output.
- [#14891](https://gitlab.com/scilab/scilab/-/issues/14891): `set_io` was not documented.
- [#14934](https://gitlab.com/scilab/scilab/-/issues/14934): Deleting a datatip with `delete(dtHandle)` created a ghost "????" component.
- [#14938](https://gitlab.com/scilab/scilab/-/issues/14938): After datatips were reforged, `SCI/modules/graphics/macros/datatips/` contained useless functions.
- [#15405](https://gitlab.com/scilab/scilab/-/issues/15405): Accessing H5::CompType in a HDF5 file made Scilab crash.
- [#15732](https://gitlab.com/scilab/scilab/-/issues/15732): In a `try` block, `continue` was ignored.
- [#15946](https://gitlab.com/scilab/scilab/-/issues/15946): `./configure` did not detect JARs symbolic links.
- [#16136](https://gitlab.com/scilab/scilab/-/issues/16136): `sound()` was a duplicate of `playsnd()` and has been removed.
- [#16897](https://gitlab.com/scilab/scilab/-/issues/16897): Scilab did not build against Lucene 9.4.0.
- [#16928](https://gitlab.com/scilab/scilab/-/issues/16928): Manually created ticks are not saved.
- [#17071](https://gitlab.com/scilab/scilab/-/issues/17071): Math rendering worked only if the whole text was notated as LaTeX.
- [#17177](https://gitlab.com/scilab/scilab/-/issues/17177): Some blocks had blank icons with users palettes in Xcos.
- [#17187](https://gitlab.com/scilab/scilab/-/issues/17187): Behavior of `bar()` was inconsistent.
- [#17210](https://gitlab.com/scilab/scilab/-/issues/17210): Routine "datatipManagerMode.sci" did not work and generated errors.
- [#17216](https://gitlab.com/scilab/scilab/-/issues/17216): `findobj(propertyName, propertyValue, ...)` statement did not work as explained in documentation.
- [#17230](https://gitlab.com/scilab/scilab/-/issues/17230): Scilab did not build against HDF5 >= 1.10.
- [#17251](https://gitlab.com/scilab/scilab/-/issues/17251): First example in XML Objects help page was broken.
- [#17252](https://gitlab.com/scilab/scilab/-/issues/17252): `uiimport()` code export failed when using a non-alphanumeric in variable used as time.
- [#17253](https://gitlab.com/scilab/scilab/-/issues/17253): `uiimport()` failed with TAB as delimiter when having some spaces variable names.
- [#17254](https://gitlab.com/scilab/scilab/-/issues/17254): `uiimport()` failed to import files with multiple header lines.
- [#17257](https://gitlab.com/scilab/scilab/-/issues/17257): Properties of `Grayplot` and `Champ` entities could no more be displayed in the Scilab console.
- [#17259](https://gitlab.com/scilab/scilab/-/issues/17259): Valgrind reported a memleak on `string([1 2])`.
- [#17260](https://gitlab.com/scilab/scilab/-/issues/17260): `uiimport()` failed to import a .txt file but succeeded with the same file renamed in .csv.
- [#17262](https://gitlab.com/scilab/scilab/-/issues/17262): Scilab did not build against libxml2 >= 2.12.7.
- [#17264](https://gitlab.com/scilab/scilab/-/issues/17264): `datetime()` help page had two history sections.
- [#17267](https://gitlab.com/scilab/scilab/-/issues/17267): Scrollbar was not available for some documentation pages.
- [#17268](https://gitlab.com/scilab/scilab/-/issues/17268): Display was wrong for `zpk` or `state-space` variables.
- [#17269](https://gitlab.com/scilab/scilab/-/issues/17269): Arguments block does not allow to check dimension over input dimensions.
- [#17272](https://gitlab.com/scilab/scilab/-/issues/17272): `datetime("1999-06","InputFormat","yyyy-MM")` produced an error.
- [#17274](https://gitlab.com/scilab/scilab/-/issues/17274): `toJSON()` created "\/" strings instead of "/".
- [#17275](https://gitlab.com/scilab/scilab/-/issues/17275): `legend()` made Scilab crash when an empty value was used as the first input argument and `5` as the second one.
- [#17277](https://gitlab.com/scilab/scilab/-/issues/17277): Setting `mxstep` in ODEOPTIONS does work with ODE type `rkf` and it was not documented.
- [#17279](https://gitlab.com/scilab/scilab/-/issues/17279): Extraction of an unknown field from a struct (or library) created inside a function made Scilab crash.
- [#17280](https://gitlab.com/scilab/scilab/-/issues/17280): `cvode()` could make Scilab crash under Windows because of uncaught exception.
- [#17283](https://gitlab.com/scilab/scilab/-/issues/17283): Outline display was slow for big matrices in `struct`, `tlist`, etc...
- [#17285](https://gitlab.com/scilab/scilab/-/issues/17285): `leastsq()` could make Scilab crash in case of error under macOS/arm64.
- [#17287](https://gitlab.com/scilab/scilab/-/issues/17287): SUNDIALS ODE solvers failed to extend complex ODEs.
- [#17288](https://gitlab.com/scilab/scilab/-/issues/17288): `graypolarplot()` failed when called with 4 or 5 input arguments.
- [#17289](https://gitlab.com/scilab/scilab/-/issues/17289): Some fields of user-type objects were not displayed.
- [#17292](https://gitlab.com/scilab/scilab/-/issues/17292): `size()` did not return any output for vectors of `datetime`.
- [#17293](https://gitlab.com/scilab/scilab/-/issues/17293): `datetime` type was not managed in `datenum()` and `datevec()`.
- [#17294](https://gitlab.com/scilab/scilab/-/issues/17294): `dae("root2",...)` did not work as documented.
- [#17298](https://gitlab.com/scilab/scilab/-/issues/17298): Documentation of `synchronize()` now explains how to use lists of timeseries as input arguments.
- [#17300](https://gitlab.com/scilab/scilab/-/issues/17300): `captions()` input/output order was inconsistent. This function has been set as obsolete.
- [#17307](https://gitlab.com/scilab/scilab/-/issues/17307): Ghost `Datatip` object was found by `get()` after deletion of parent figure.
- [#17311](https://gitlab.com/scilab/scilab/-/issues/17311): Scilab crashed when running n-pendulum demonstration.
- [#17312](https://gitlab.com/scilab/scilab/-/issues/17312): `compress()` could not compress a single file without a container.
- [#17315](https://gitlab.com/scilab/scilab/-/issues/17315): `addmenu()` documentation example could not be executed.
