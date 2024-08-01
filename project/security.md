# Security

Security is a primary concern for us in the curl project. We take it seriously
and we work hard on providing secure and safe implementations of all protocols
and related code. As soon as we get knowledge about a security related problem
or just a suspected problem, we deal with it and we attempt to provide a fix
and security notice no later than in the next pending release.

We use a responsible disclosure policy, meaning that we prefer to discuss and
work on security fixes out of the public eye and we alert the vendors on the
openwall.org list a few days before we announce the problem and fix to the
world. This, in an attempt to shorten the time span the bad guys can take
advantage of a problem until a fixed version has been deployed.

## Past security problems

During the years we have had our fair share of security related problems. We
work hard on [documenting every
problem](https://curl.se/docs/security.html) thoroughly with all details
listed and clearly stated to aid users. Users of curl should be able to figure
out what problems their particular curl versions and use cases are vulnerable
to.

To help with this, we present [this waterfall
chart](https://curl.se/docs/vulnerabilities.html) showing how all
vulnerabilities affect which curl versions and we have this complete list of
all known security problems since the birth of this project.

## Backdoors and supply chain risks

With libcurl being installed and running in billions of installations all over
the world and in countless different environments, we recognize that it is an
ideal target for someone who wants a backdoor somewhere.

A new or old maintainer might at any point propose a change that sounds
innocent and well-meaning but has a disguised malicious intent.

To mitigate such risks, we apply established procedures and techniques:

- **GitHub**. The curl project uses <https://github.com/curl/curl> as its main
  source code git repository since 2010. We rely on their hosting to secure
  access as per our configuration.
- **2FA required**. We require all maintainers with push access to git to have
  two-factor authentication enabled, to reduce the risk that attackers can
  impersonate them and use their credentials to push source code changes. We
  rely on GitHub's 2fa setup.
- **Reviews**. Every contribution that are proposed for inclusion in the
  project is reviewed by a maintainer. All changes are always done publicly in
  the open to allow all interested parties to participate. No invitation
  needed. All changes are also automatically checked, tested and scanned by
  numerous tools before accepted.
- **Readable code**. We believe in readable code that follows our code style.
  Easy to read makes it easy to debug. If code is hard to read it should be
  improved until it gets easy to read. With easy to read code, smuggling
  malicious payloads or hiding nefarious functionality is excruciatingly hard.
- **Tests**. We have a large test suite that is always growing and we do not
  accept changes that break existing tests and new functionality need to bring
  new tests for the new functionality. We run *several hundred thousands*
  tests on each proposed changed to make sure existing functionality remains.
  This includes fuzzers, static code analyzers, fault injectors and more.
- **No binary blobs**. All files stored in version control, in the git
  repository is readable or is otherwise small and documented. There is no
  place anywhere for any hidden encrypted payload.
- **Reproducible builds**. curl releases are shipped as tarballs that are
  hosted on the curl website. We provide documentation, docker setups and
  setups etc that allows anyone wanting to easily reproduce our release builds
  to generate identical images - proving that what we ship is only contents
  taken from the git repository plus other correct and properly generated
  contents.
- **Signed commits**. Over 90% - not all - of recent commits were signed to
  help prove provenance. Signing commits is not yet a mandatory requirement
  for committers but we hope to voluntarily increase the share over time and
  make it mandatory soon.
- **Signed releases**. Every release, every uploaded tarball, is signed by
  Daniel. This helps to prove that the files have not been tampered with since
  they were produced. We have opted to not sign them by multiple persons only
  because of the added complexity for the relatively small extra protection.
- **Fix all vulnerabilities quickly**. Whenever we receive a security
  vulnerability report, we create and ship a fix in the next pending release.
  Sometimes sooner than previously planned. Only in extremely rare cases does
  it take longer than a release cycle, but in the name of accuracy and
  correctness we do reserve the right to spend time on research to get it
  right. With every fixed security vulnerability we release a detailed
  description of the flaw including exact commit that introduced the problem,
  recommendations for users and more. Further, the security advisories get
  announced to the world.
