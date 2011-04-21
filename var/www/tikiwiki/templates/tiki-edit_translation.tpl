<h1><a href="{$smarty.server.REQUEST_URI}">{tr}Edit Translation:{/tr}&nbsp;{$name}</a>
{if $feature_help eq 'y'}
<a href="http://tikiwiki.org/tiki-index.php?page=Internationalization" target="tikihelp" class="tikihelp" title="{tr}Tikiwiki.org help{/tr}: {tr}edit translations{/tr}"><img src="img/icons/help.gif" border="0" height="16" width="16" alt='{tr}help{/tr}' /></a>
{/if}
{if $feature_view_tpl eq 'y'}
<a href="tiki-edit_templates.php?template=tiki-edit_translation.tpl" target="tikihelp" class="tikihelp" title="{tr}View template{/tr}: {tr}edit translations template{/tr}"><img src="img/icons/info.gif" border="0" width="16" height="16" alt='{tr}Edit template{/tr}' /></a>
{/if}
</h1>

{if $type == "wiki page"}
	<a href="tiki-index.php?page={$name|escape:url}" class="linkbut" title="{tr}view{/tr}">{tr}View page{/tr}</a>
{else}
	<a href="tiki-read_article.php?articleId={$id}" class="linkbut" title="{tr}view{/tr}">{tr}View{/tr}</a>
{/if}

{if $error}
	<div class="error">
	{if $error == "traLang"}
		{tr}You must specify the object language{/tr}
	{elseif $error == "srcExists"}
		{tr}The object doesn't exist{/tr}
	{elseif $error == "srcLang"}
		{tr}The object doesn't have a language{/tr}
	{elseif $error == "alreadyTrad"}
		{tr}The object has already a translation for this language{/tr}
	{elseif $error == "alreadySet"}
		{tr}The object is already in the set of translations{/tr}
	{/if}
	</div>
	<br />
{/if}

<form action="tiki-edit_translation.php" method="post">
<input type="hidden" name="id" value="{$id}" />
<input type="hidden" name="type" value="{$type|escape}" />

<h2>{tr}Language: {/tr}{$name}</h2>
<p>{tr}Use this section to set the language of the version you are currently working on.{/tr}</p>
<table>
<tr>
	<td><select name="langpage" size="1">
	{if !$langpage || $langpage == "NULL"}
	<option value="">{tr}Unknown{/tr}</option>
	{/if}
	{section name=ix loop=$languages}
	{if in_array($languages[ix].value, $available_languages) or $available_languages|@count eq 0}
	<option value="{$languages[ix].value|escape}"{if $langpage eq $languages[ix].value} selected="selected"{/if}>{$languages[ix].name}</option>
	{/if}
	{/section}</select>
	</td>
	{if count(trads)}
		<td class="form">
		<input type="submit" value="{tr}Save{/tr}" /><br />
		</td>
	{/if}
</tr>
</table>
<br />

<h2>{tr}Set of Translations{/tr}</h2>

{if count($trads) > 1}
	<table class="normal">
	<tr><td class="heading">{tr}Language{/tr}</td><td class="heading">{tr}Page{/tr}</td><td class="heading">{tr}Actions{/tr}</td></tr>
	{cycle values="odd,even" print=false}
	{section name=i loop=$trads}
	<tr class="{cycle}">
		<td>{$trads[i].langName}</td>
		<td>{if $type == 'wiki page'}<a href="tiki-index.php?page={$trads[i].objName|escape:url}">{else}<a href="tiki-read_article.php?articleId={$trads[i].objId|escape:url}">{/if}{$trads[i].objName}</a></td>
		<td><a class="link" href="tiki-edit_translation.php?detach&amp;id={$id|escape:url}&amp;srcId={$trads[i].objId|escape:url}&amp;type={$type|escape:url}">{html_image file='img/icons2/delete.gif' border='0' alt='{tr}detach{/tr}' title='{tr}detach{/tr}'}</a>
	</td></tr>
	{/section}
	</table>
	<table><tr><td>

	{if $articles}
		<select name="srcId">{section name=ix loop=$articles}<option value="{$articles[ix].articleId|escape}" {if $articles[ix].articleId == $srcId}checked="checked"{/if}>{$articles[ix].title|truncate:40:"(...)":true}</option>{/section}</select>
	{else}
		<select name="srcName">{section name=ix loop=$pages}<option value="{$pages[ix].pageName|escape}" {if $pages[ix].pageName == $srcId}checked="checked"{/if}>{$pages[ix].pageName|truncate:40:"(...)":true}</option>{/section}</select>
	{/if}
	&nbsp;<input type="submit" class="wikiaction"  value="{tr}add to the set{/tr}"/>
	</td></tr></table>

{else} {* first translation *}
	{if $articles}
		<p>{tr}Select the article for which the current article is the translation.{/tr}</p>
		{tr}Translation of:{/tr}&nbsp;
		<select name="srcId">{section name=ix loop=$articles}<option value="{$articles[ix].articleId|escape}">{$articles[ix].title|truncate:40:"(...)":true}</option>{/section}</select>
	{else}
		<p>{tr}Enter the name of the page for which the current page is the translation.{/tr}</p>
		{tr}Translation of:{/tr}&nbsp;
		<select name="srcName">{section name=ix loop=$pages}<option value="{$pages[ix].pageName|escape}">{$pages[ix].pageName|truncate:40:"(...)":true}</option>{/section}</select>

	{/if}
	&nbsp;<input type="submit" class="wikiaction"  value="{tr}go{/tr}"/>
{/if}
</form>
