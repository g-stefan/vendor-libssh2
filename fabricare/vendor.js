// Created by Grigore Stefan <g_stefan@yahoo.com>
// Public domain (Unlicense) <http://unlicense.org>
// SPDX-FileCopyrightText: 2022-2023 Grigore Stefan <g_stefan@yahoo.com>
// SPDX-License-Identifier: Unlicense

messageAction("vendor");

Project.vendor = Project.name + "-" + Project.version;

Shell.mkdirRecursivelyIfNotExists("archive");

// Self
if (Shell.fileExists("archive/" + Project.vendor + ".7z")) {
	if (Shell.getFileSize("archive/" + Project.vendor + ".7z") > 16) {
		return;
	};
	Shell.removeFile("archive/" + Project.vendor + ".7z");
};

var vendorSourceGit = "https://github.com/g-stefan";
if (Shell.hasEnv("VENDOR_SOURCE_GIT")) {
	vendorSourceGit = Shell.getenv("VENDOR_SOURCE_GIT");
};

exitIf(Shell.system("curl --insecure --location " + vendorSourceGit + "/vendor-" + Project.name + "/releases/download/v" + Project.version + "/" + Project.vendor + ".7z --output archive/" + Project.vendor + ".7z"));
if (Shell.getFileSize("archive/" + Project.vendor + ".7z") > 16) {
	return;
};
Shell.removeFile("archive/" + Project.vendor + ".7z");

// Source
runInPath("archive", function() {
	webLink = "https://github.com/libssh2/libssh2/releases/download/libssh2-1.10.0/libssh2-1.10.0.tar.gz";
	if (!Shell.fileExists(Project.vendor + ".tar.gz")) {
		exitIf(Shell.system("curl --insecure --location " + webLink + " --output " + Project.vendor + ".tar.gz"));
	};
	exitIf(Shell.system("7z x " + Project.vendor + ".tar.gz -so | 7z x -aoa -si -ttar -o."));
	Shell.removeFile(Project.vendor + ".tar.gz");
	Shell.removeFile(Project.vendor + ".7z");
	exitIf(Shell.system("7z a -mx9 -mmt4 -r- -sse -w. -y -t7z " + Project.vendor + ".7z " + Project.vendor));
	Shell.removeDirRecursively(Project.vendor);
});
