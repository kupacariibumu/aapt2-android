/*
 * Copyright (C) 2015, The Android Open Source Project *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#pragma once

#include <set>
#include <string>
#include <vector>

#include "diagnostics.h"

namespace android {
namespace aidl {

using std::set;
using std::string;
using std::vector;

// A simple wrapper around ostringstream. This is just to make Options class
// copiable by the implicit copy constructor. If ostingstream is not wrapped,
// the implcit copy constructor is not generated because ostringstream isn't
// copiable. This class makes the field copiable by having a copy constructor
// that does not copy the underlying stream.
class ErrorMessage {
 public:
  ErrorMessage() = default;
  ErrorMessage(const ErrorMessage&) {}
  std::ostringstream stream_;

  template <typename T>
  ErrorMessage& operator<<(T& t) {
    stream_ << t;
    return *this;
  }

  template <typename T>
  ErrorMessage& operator<<(const T& t) {
    stream_ << t;
    return *this;
  }

  // for "<< endl"
  ErrorMessage& operator<<(std::ostream& (*f)(std::ostream&)) {
    f(stream_);
    return *this;
  }
};

// Handles warning-related options (e.g. -W, -w, ...)
class WarningOptions {
 public:
  std::vector<const char*> Parse(int argc, const char* const argv[], ErrorMessage& error_message);
  DiagnosticMapping GetDiagnosticMapping() const;

 private:
  bool as_errors_ = false;           // -Werror
  bool enable_all_ = false;          // -Weverything
  bool disable_all_ = false;         // -w
  std::set<std::string> enabled_;    // -Wfoo
  std::set<std::string> disabled_;   // -Wno-foo
  std::set<std::string> no_errors_;  // -Wno-error=foo
};

class Options final {
 public:
  enum class Language { UNSPECIFIED, JAVA, CPP, NDK, RUST };

  enum class Task { HELP, COMPILE, PREPROCESS, DUMP_API, CHECK_API, DUMP_MAPPINGS };

  enum class CheckApiLevel { COMPATIBLE, EQUAL };

  enum class Stability { UNSPECIFIED, VINTF };
  bool StabilityFromString(const std::string& stability, Stability* out_stability);

  Options(int argc, const char* const argv[], Language default_lang = Language::UNSPECIFIED);

  Options PlusImportDir(const std::string& import_dir) const {
    Options copy(*this);
    copy.import_dirs_.insert(import_dir);
    return copy;
  }

  static Options From(const string& cmdline);

  static Options From(const vector<string>& args);

  // Contain no references to unstructured data types (such as a parcelable that is
  // implemented in Java). These interfaces aren't inherently stable but they have the
  // capacity to be stabilized.
  bool IsStructured() const { return structured_; }

  Stability GetStability() const { return stability_; }

  Language TargetLanguage() const { return language_; }
  bool IsCppOutput() const { return language_ == Language::CPP || language_ == Language::NDK; }

  Task GetTask() const { return task_; }

  CheckApiLevel GetCheckApiLevel() const { return check_api_level_; }

  const set<string>& ImportDirs() const { return import_dirs_; }

  const vector<string>& PreprocessedFiles() const { return preprocessed_files_; }

  string DependencyFile() const {
    return dependency_file_;
  }

  bool AutoDepFile() const { return auto_dep_file_; }

  bool GenRpc() const { return gen_rpc_; }

  bool GenTraces() const { return gen_traces_; }

  bool GenTransactionNames() const { return gen_transaction_names_; }

  bool DependencyFileNinja() const { return dependency_file_ninja_; }

  const vector<string>& InputFiles() const { return input_files_; }

  // Path to the output file. This is used only when there is only one
  // output file for the invocation. When there are multiple outputs
  // (e.g. compile multiple AIDL files), output files are created under
  // OutputDir().
  const string& OutputFile() const { return output_file_; }

  // Path to the directory where output file(s) will be generated under.
  const string& OutputDir() const { return output_dir_; }

  // Path to the directory where header file(s) will be generated under.
  // Only used when TargetLanguage() == Language::CPP
  const string& OutputHeaderDir() const { return output_header_dir_; }

  bool FailOnParcelable() const { return fail_on_parcelable_; }

  int Version() const { return version_; }

  string Hash() const { return hash_; }

  bool GenLog() const { return gen_log_; }

  bool DumpNoLicense() const { return dump_no_license_; }

  bool Ok() const { return error_message_.stream_.str().empty(); }

  string GetErrorMessage() const { return error_message_.stream_.str(); }

  string GetUsage() const;

  bool GenApiMapping() const { return task_ == Task::DUMP_MAPPINGS; }

  DiagnosticMapping GetDiagnosticMapping() const { return warning_options_.GetDiagnosticMapping(); }

  // The following are for testability, but cannot be influenced on the command line.
  // Threshold of interface methods to enable outlining of onTransact cases.
  size_t onTransact_outline_threshold_{275u};
  // Number of cases to _not_ outline, if outlining is enabled.
  size_t onTransact_non_outline_count_{275u};

 private:
  Options() = default;

  const string myname_;
  Language language_ = Language::UNSPECIFIED;
  Task task_ = Task::COMPILE;
  CheckApiLevel check_api_level_ = CheckApiLevel::COMPATIBLE;
  set<string> import_dirs_;
  vector<string> preprocessed_files_;
  string dependency_file_;
  bool gen_rpc_ = false;
  bool gen_traces_ = false;
  bool gen_transaction_names_ = false;
  bool dependency_file_ninja_ = false;
  bool structured_ = false;
  Stability stability_ = Stability::UNSPECIFIED;
  string output_dir_;
  string output_header_dir_;
  bool fail_on_parcelable_ = false;
  bool auto_dep_file_ = false;
  vector<string> input_files_;
  string output_file_;
  int version_ = 0;
  string hash_ = "";
  bool gen_log_ = false;
  bool dump_no_license_ = false;
  ErrorMessage error_message_;
  WarningOptions warning_options_;
};

std::string to_string(Options::Language language);

}  // namespace aidl
}  // namespace android
