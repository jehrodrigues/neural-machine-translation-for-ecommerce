#!/usr/bin/perl

# Alterado em 25/03/2009
# Removi as partes que faziam diferenciacao para formato de saida de acordo com a medida desejada
# Agora o formato de saida desse script eh aquele exigido pelo script mteval-v11b.pl, o mesmo do Moses

use warnings;
use strict;
use locale;

if ($#ARGV < 4) {
	print "Uso: $0 <arq> <sistema> <lingua_fonte> <lingua_alvo> <arq_saida> [lc]\n";
	print "\t<arq>: arquivo com sentencas no formato <s snum=d+>...</s> para formatar\n";
	print "\t<sistema>: indicacao do sistema que deu origem ahs sentencas. Ex: ref, src, test, none\n";
	print "\t<lingua_fonte>: indicacao da lingua fonte. Ex:pt\n<lingua_alvo>: indicacao da lingua alvo. Ex: es\n\n";	
	exit 1;
}

my $arq = shift(@ARGV);
my $sisid = shift(@ARGV);
my	$fon = shift(@ARGV);
my $alv = shift(@ARGV);
my $saida = shift(@ARGV);

my $min = 0;
if (($#ARGV >= 0) && ($ARGV[0] eq "lc")) {
	$min = 1;
}

formata();

# FORMATA 
sub formata {
	my($docid,$setid);
	
#	$docid = nome($arq);

	$docid = "teste"; # para todos ficarem iguais e poder rodar o bootstrapping

	if ($docid =~ /^([^\_]+)\_.+$/) { $setid = $1; }
	else { $setid = "SEM_NOME_DEFINIDO" ;}
	open(OUT,">$saida") or die "Nao eh possivel abrir o arquivo $saida\n";
	if ($sisid eq "src") { 
		print OUT "<srcset setid=\"$setid\" srclang=\"$fon\">\n"; 
		print OUT "<DOC docid=\"$docid\">\n";
	}
	else {
		if ($sisid eq "ref") { print OUT "<refset setid=\"$setid\" srclang=\"$fon\" trglang=\"$alv\">\n"; }
		else { print OUT "<tstset setid=\"$setid\" srclang=\"$fon\" trglang=\"$alv\">\n"; }
		print OUT "<DOC docid=\"$docid\" sysid=\"$sisid\">\n";
	}
	close OUT;
	if ($sisid ne "none") { 
		imprime_sentencas($arq,"seg",$saida); 
		open(OUT,">>$saida") or die "Nao eh possivel abrir o arquivo $saida\n";
		print OUT "</DOC>\n";
	}
	else { imprime_sentencas($arq,"",$saida); }
	if ($sisid eq "ref") { print OUT "</refset>\n"; }
	elsif ($sisid eq "src") { print OUT "</srcset>\n"; }
	elsif ($sisid eq "test") { print OUT "</tstset>\n"; }	
	close OUT;
}

# IMPRIME SENTENCAS
sub imprime_sentencas {
	my($entrada,$eti,$saida) = @_;
	my($id,$sent,@tokens); # 25/03/2009 - criei array @tokens

	$id = 1;
	open(OUT,">>$saida") or die "Nao eh possivel abrir o arquivo $saida\n";
	open(FILE,$entrada) or die "Nao eh possivel abrir o arquivo $entrada\n";
	while (<FILE>) {
		if (/<s snum=([^>]+)>(.+)<\/s>/) {
			$id = $1;
			$sent = $2;
		}
		else { $sent = $_; }

		if ($min) { $sent = lc($sent); }

		if ($sent =~ /\w/) {
			$sent =~ s/\n//;
#			print "$sent\n"; exit;
#			@tokens = split(/ +/,separa_tokens($sent));
			@tokens = split(/ +/,$sent);
#			if ($caracteres == 0) {
#				@tokens = grep(/\w+/,@tokens); # mantem em @tokens apenas os tokens que contem pelo menos 1 letra
#			}
#			if ($minuscula == 1) {
#				map($_ = lc($_),@tokens);
#			}
			if ($eti ne "") { print OUT "<$eti id=\"$id\">",join(" ",@tokens),"</$eti>\n"; }
			else { print OUT join(" ",@tokens),"\n"; }
			$id++;

		}			
	}
	close FILE;   	
	close OUT;
}

sub nome {
  my $arq = $_[0];
  
  my(@aux,$c);
  @aux = split(/\//,$arq);
  $arq = $aux[$#aux];
  if ($arq =~ /\./) {
	  do { $c = chop($arq); }
  	until ($c eq '.');    
  }
  return $arq;
}


