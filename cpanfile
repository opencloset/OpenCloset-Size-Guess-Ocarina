requires "HTTP::Tiny" => "0.056";
requires "IO::Socket::SSL" => "0";
requires "JSON" => "0";
requires "List::MoreUtils" => "0";
requires "Moo" => "0";
requires "Mozilla::CA" => "0";
requires "Net::SSLeay" => "0";
requires "OpenCloset::Size::Guess" => "0.003";
requires "OpenCloset::Size::Guess::Role::Base" => "0";
requires "Try::Tiny" => "0";
requires "Types::Standard" => "0";
requires "perl" => "5.010";
requires "utf8" => "0";

on 'test' => sub {
  requires "ExtUtils::MakeMaker" => "0";
  requires "File::Spec" => "0";
  requires "Test::More" => "0";
  requires "perl" => "5.010";
  requires "strict" => "0";
  requires "warnings" => "0";
};

on 'test' => sub {
  recommends "CPAN::Meta" => "2.120900";
};

on 'configure' => sub {
  requires "ExtUtils::MakeMaker" => "6.17";
  requires "perl" => "5.010";
};

on 'configure' => sub {
  suggests "JSON::PP" => "2.27300";
};

on 'develop' => sub {
  requires "Dist::Zilla" => "5";
  requires "Dist::Zilla::Plugin::Prereqs" => "0";
  requires "Dist::Zilla::PluginBundle::DAGOLDEN" => "0";
  requires "English" => "0";
  requires "File::Spec" => "0";
  requires "File::Temp" => "0";
  requires "IO::Handle" => "0";
  requires "IPC::Open3" => "0";
  requires "Pod::Coverage::TrustPod" => "0";
  requires "Pod::Wordlist" => "0";
  requires "Software::License::Perl_5" => "0";
  requires "Test::CPAN::Meta" => "0";
  requires "Test::More" => "0";
  requires "Test::Pod" => "1.41";
  requires "Test::Pod::Coverage" => "1.08";
  requires "Test::Portability::Files" => "0";
  requires "Test::Spelling" => "0.12";
  requires "Test::Version" => "1";
  requires "blib" => "1.01";
  requires "perl" => "5.006";
  requires "strict" => "0";
  requires "warnings" => "0";
};
