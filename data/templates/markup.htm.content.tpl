<div class="site_content">

<h1 class=\"main_title\">Comment Markup:</h1>
<hr class=\"main_hr\" />

<h2>Documentation comment structure:</h2>
<hr class=\"main_hr\" />
<div class=\"main_code_definition\">
<pre>/**
 * brief description
 * 
 * long description
 *
 * taglets
 */</pre>
</div>

<br />

<h2>Linebreaks and paragraphs:</h2>
<hr class=\"main_hr\" />
<h3>Comment:</h3>
<div class=\"main_code_definition\">
<pre>/**
 * First paragraph,
 * still the first paragraph
 *
 * Second paragraph, first line,&lt;&lt;BR&gt;&gt;
 * second paragraph, second line
 */</pre>
</div>
<h3>Output:</h3>
<div class=\"main_code_definition\">
<p>First paragraph, still the first paragraph</p>
<p>Second paragraph, first line, <br /> second paragraph, second line</p>
</div>

<br />

<h2>Text highlighting:</h2>
<hr class=\"main_hr\" />
<h3>Comment:</h3>
<div class=\"main_code_definition\">
<pre>/**
 * ''bold'' //italic// __underlined__ ``block quote``,
 * ''//__bold italic underlined__//''
 */
</pre>
</div>
<h3>Output:</h3>
<div class=\"main_code_definition\">
<p><b>bold</b> <i>italic</i> <u>underlined</u> <span>block quote</span> <b><i><u>bold italic underlined</u></i></b></p>
</div>

<br />

<h2>Lists:</h2>
<hr class=\"main_hr\" />
<p>Two spaces are required after newlines.</p>
<h3>Comment:</h3>
<div class=\"main_code_definition\">
<pre>/**
 * short description
 *
 *  1. numbered list
 *  1. numbered list
 *  1. numbered list
 *
 *  # numbered list
 *  # numbered list
 *  # numbered list
 *
 *  i. numbered list
 *  i. numbered list
 *  i. numbered list
 *
 *  I. numbered list
 *  I. numbered list
 *  I. numbered list
 *
 *  a. alphabetical list
 *  a. alphabetical list
 *  a. alphabetical list
 *
 *  A. alphabetical list
 *  A. alphabetical list
 *  A. alphabetical list
 *
 *  * doted list
 *  * doted list
 *  * doted list
 *
 *  A. alphabetical list
 *    a. alphabetical list
 *    a. alphabetical list
 *  A. alphabetical list
 *    a. alphabetical list
 *    a. alphabetical list
 *  A. alphabetical list
 */
</pre>
</div>
<h3>Output:</h3>
<div class=\"main_code_definition\">
<ol type=\"1\">
  <li>numbered list</li>
  <li>numbered list</li>
  <li>numbered list</li>

</ol>
<ol>
  <li>numbered list</li>
  <li>numbered list</li>
  <li>numbered list</li>
</ol>
<ol type=\"i\">

  <li>numbered list</li>
  <li>numbered list</li>
  <li>numbered list</li>
</ol>
<ol type=\"I\">
  <li>numbered list</li>
  <li>numbered list</li>

  <li>numbered list</li>
</ol>
<ol type=\"a\">
  <li>alphabetical list</li>
  <li>alphabetical list</li>
  <li>alphabetical list</li>
</ol>

<ol type=\"A\">
  <li>alphabetical list</li>
  <li>alphabetical list</li>
  <li>alphabetical list</li>
</ol>
<ul>
  <li>doted list</li>

  <li>doted list</li>
  <li>doted list</li>
</ul>
<ol type=\"A\">
  <li>alphabetical list
    <ol type=\"a\">
      <li>alphabetical list</li>
      <li>alphabetical list</li>

    </ol></li>
  <li>alphabetical list
    <ol type=\"a\">
      <li>alphabetical list</li>
      <li>alphabetical list</li>
    </ol></li>
  <li>alphabetical list</li>
</ol>
</div>




<br />
<h2>Code:</h2>
<hr class=\"main_hr\" />
<h3>Comment:</h3>
<div class=\"main_code_definition\">
<pre>/**
 * Short description
 *
 * {{{
 *   static int main (string[] arg) {
 *      return 0;
 *   }
 * }}}
 *
 */</pre>
</div>
<h3>Output:</h3>
<div class=\"main_code_definition\">
 <p>Short description</p>

<pre>   static int main (string[] arg) {
      return 0;
   }</pre>
</div>



<br />
<h2>Images and links:</h2>
<hr class=\"main_hr\" />
<h3>Comment:</h3>
<div class=\"main_code_definition\">
<pre>/**
 * [[http://google.at|google]] [[http://google.at]]
 *
 * {{/images/favicon.png}} {{/images/favicon.png|alt-message}}
 */
</pre>
</div>
<h3>Output:</h3>
<div class="main_code_definition">
<p><a href="http://google.at">google</a> <a href="http://google.at">http://google.at</a></p>
<p><img src="/images/favicon.png" /> <img src="/images/favicon.png" alt="alt-message" /></p>
</div>







<br />

<h2>Tables:</h2>
<hr class=\"main_hr\" />
<h3>Comment:</h3>
<div class=\"main_code_definition\">
<pre>/**
 * Short description
 *
 * || ''headline'' || ''headline'' ||
 * || one cell || one cell ||
 * || one cell || one cell ||
 *
 */</pre>
</div>
<h3>Output:</h3>
<div class=\"main_code_definition\">
<p>Short description</p>

<table style=\"margin: auto;\">
<tr>
	<td><b>headline</b></td>
	<td><b>headline</b></td>
</tr>
<tr>
	<td>one cell</td>
	<td>one cell</td>
</tr>
<tr>
	<td>one cell</td>
	<td>one cell</td>
</tr>
</table>
</div>





<br />
<h2 class=\"main_title\">Wiki Markup:</h2>
<hr class=\"main_hr\" />

<h3>Linebreaks, paragraphs, tables, ...</h3>
<hr class=\"main_hr\" />
<p>See the comment-section for details.</p>


<br />
<h2>Headlines:</h2>
<hr class=\"main_hr\" />
<h3>Comment:</h3>
<div class=\"main_code_definition\">
<pre>= headline 1 =
== headline 2 ==
=== headline 3 ===
==== headline 4 ====
</pre>
</div>
<h3>Output:</h3>
<div class=\"main_code_definition\">
<h1>headline 1</h1>
<h2>headline 2</h2>
<h3>headline 3</h3>
<h4>headline 4</h4>
</div>





<br />
<h2 class=\"main_title\">Taglets:</h2>
<hr class=\"main_hr\" />

<p>There are two types of taglets:</p>


<ul>
	<li>Inline taglets</li>
	<li>Block taglets</li>
</ul>

<p>Inline taglets (link, inheritDoc) are used inside text and block taglets (param, see, ..) are used at the end of each comment.</p>



<br />
<h3>Inline Taglets:</h3>
<hr class=\"main_hr\" />

<table style=\"margin: auto; width: 80%;\">
<tr>
	<td><b>Taglets:</b></td>
	<td><b>Synopsis:</b></td>
	<td><b>Descriptions:</b></td>
<tr>
<tr>
	<td>inheritDoc</td>
	<td>{@inheritDoc}</td>
	<td>Used to directly inherit descriptions from the parent</td>
</tr>
<tr>
	<td>link</td>
	<td>{@link [node]}</td>
	<td>-</td>
</tr>
</table>

<br />
<h3>Block Taglets:</h3>
<hr class=\"main_hr\" />

<table style=\"margin: auto; width: 80%;\">
<tr>
	<td><b>Taglets:</b></td>
	<td><b>Synopsis:</b></td>
	<td><b>Descriptions:</b></td>
</tr>
<tr>
	<td>deprecated</td>
	<td>@deprecated [version]</td>
	<td>-</td>
</tr>
<tr>
	<td>see</td>
	<td>@see [node-name]</td>
	<td>-</td>
</tr>
<tr>
	<td>param</td>
	<td>@param [parameter-name] [description]</td>
	<td>-</td>
</tr>
<tr>
	<td>since</td>
	<td>@since [version]</td>
	<td>-</td>
</tr>
<tr>
	<td>return</td>
	<td>@return [description]</td>
	<td>-</td>
</tr>
<tr>
	<td>throws</td>
	<td>@throws [type-name] [description]</td>
	<td>-</td>
</tr>
</table>

</div>

