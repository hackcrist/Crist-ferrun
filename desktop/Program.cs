using System.Diagnostics;
using System.Net;
using System.Net.Sockets;
using Microsoft.Web.WebView2.WinForms;

namespace FerrumResources.App;

internal static class Program
{
    [STAThread]
    private static void Main()
    {
        ApplicationConfiguration.Initialize();
        Application.Run(new MainForm());
    }
}

public sealed class MainForm : Form
{
    private readonly WebView2 _webView = new() { Dock = DockStyle.Fill };
    private Process? _serverProcess;
    private string _url = "http://127.0.0.1:5057";
    private readonly string _logFile = Path.Combine(
        Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData),
        "FerrumResources",
        "desktop.log");

    public MainForm()
    {
        Text = "FerrumResources";
        Width = 1280;
        Height = 820;
        MinimumSize = new Size(980, 640);
        StartPosition = FormStartPosition.CenterScreen;
        Controls.Add(_webView);
    }

    protected override async void OnShown(EventArgs e)
    {
        base.OnShown(e);
        try
        {
            _url = await StartServerAsync();
            await _webView.EnsureCoreWebView2Async();
            _webView.CoreWebView2.Navigate(_url);
        }
        catch (Exception ex)
        {
            Log(ex.ToString());
            MessageBox.Show(
                $"No se pudo iniciar FerrumResources.\n\n{ex.Message}",
                "FerrumResources",
                MessageBoxButtons.OK,
                MessageBoxIcon.Error);
            Close();
        }
    }

    protected override void OnFormClosing(FormClosingEventArgs e)
    {
        base.OnFormClosing(e);
        try
        {
            if (_serverProcess is { HasExited: false })
            {
                _serverProcess.Kill(entireProcessTree: true);
            }
        }
        catch
        {
            // El proceso ya pudo cerrarse por su cuenta.
        }
    }

    private async Task<string> StartServerAsync()
    {
        var baseDir = AppContext.BaseDirectory;
        var serverExe = Path.Combine(baseDir, "Server", "FerrumResources.exe");
        Log($"Base: {baseDir}");
        Log($"Servidor: {serverExe}");
        if (!File.Exists(serverExe))
        {
            throw new FileNotFoundException("No se encontró el servidor interno.", serverExe);
        }

        var port = FindPort(5057, 5090);
        var url = $"http://127.0.0.1:{port}";

        var startInfo = new ProcessStartInfo("cmd.exe")
        {
            Arguments = $"/c \"\"{serverExe}\"\"",
            UseShellExecute = false,
            CreateNoWindow = true,
            WindowStyle = ProcessWindowStyle.Hidden,
            WorkingDirectory = Path.GetDirectoryName(serverExe)!
        };
        startInfo.Environment["SPV_HOST"] = "127.0.0.1";
        startInfo.Environment["SPV_PORT"] = port.ToString();
        startInfo.Environment["SPV_DEBUG"] = "false";
        startInfo.Environment["SPV_OPEN_BROWSER"] = "false";

        _serverProcess = Process.Start(startInfo)
            ?? throw new InvalidOperationException("No se pudo iniciar el servidor interno.");
        Log($"Servidor iniciado PID {_serverProcess.Id} en {url}");

        for (var i = 0; i < 45; i++)
        {
            if (_serverProcess.HasExited)
            {
                throw new InvalidOperationException($"El servidor interno se cerró antes de iniciar. Código: {_serverProcess.ExitCode}");
            }

            try
            {
                using var tcp = new TcpClient();
                await tcp.ConnectAsync(IPAddress.Loopback, port);
                return url;
            }
            catch
            {
                await Task.Delay(400);
            }
        }

        throw new TimeoutException("El servidor interno tardó demasiado en responder.");
    }

    private void Log(string message)
    {
        try
        {
            Directory.CreateDirectory(Path.GetDirectoryName(_logFile)!);
            File.AppendAllText(_logFile, $"[{DateTime.Now:yyyy-MM-dd HH:mm:ss}] {message}{Environment.NewLine}");
        }
        catch
        {
            // El registro no debe impedir que la app abra.
        }
    }

    private static int FindPort(int first, int last)
    {
        for (var port = first; port <= last; port++)
        {
            try
            {
                var listener = new TcpListener(IPAddress.Loopback, port);
                listener.Start();
                listener.Stop();
                return port;
            }
            catch
            {
                // Puerto ocupado, probar el siguiente.
            }
        }

        throw new InvalidOperationException("No hay puertos disponibles para iniciar FerrumResources.");
    }
}
