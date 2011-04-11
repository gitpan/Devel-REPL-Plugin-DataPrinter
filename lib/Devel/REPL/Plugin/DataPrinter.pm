package Devel::REPL::Plugin::DataPrinter;
BEGIN {
  $Devel::REPL::Plugin::DataPrinter::VERSION = '0.002';
}
# ABSTRACT: Format REPL results with Data::Printer
use strict;
use warnings;

use Devel::REPL::Plugin;
use Data::Printer 0.08;

around 'format_result' => sub {
   my $orig = shift;
   my $self = shift;
   my @to_dump = @_;
   my $out;
   if (@to_dump != 1 || ref $to_dump[0]) {
      if (@to_dump == 1) {
         if ( overload::Method($to_dump[0], '""') ) {
            $out = "@to_dump";
         }
         else {
             $out = p $to_dump[0];
         }
      } else {
         $out = p @to_dump;
      }
   } else {
      $out = $to_dump[0];
   }
   $self->$orig($out);
};


1;


=pod

=head1 NAME

Devel::REPL::Plugin::DataPrinter - Format REPL results with Data::Printer

=head1 VERSION

version 0.002

=head1 SYNOPSIS

In your re.pl config file (usually C<< ~/.re.pl/repl.rc >>):

    load_plugin('DataPrinter');

That's about it. Your re.pl should now give you nicer outputs :)

=head1 SEE ALSO

* L<Devel::REPL>
* L<Devel::REPL::Plugin::DDS>

=head1 AUTHOR

Breno G. de Oliveira <garu@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Breno G. de Oliveira.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__

